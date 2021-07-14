# frozen_string_literal: true

class Player < ActiveRecord::Base
  has_many :tickets
  has_many :tournaments, through: :tickets

  # Existing Method from another project
  def full_name
    "#{first_name} #{last_name}"
  end

  def deposit(amount)
    new_balance = self.account_balance += amount
    update(account_balance: new_balance)
  end

  def withdraw(amount)
    if self.account_balance - amount >= 0
      new_balance = self.account_balance -= amount
      update(account_balance: new_balance)
    else
      puts "You cannot withdraw $#{amount} because you have a balance of $#{self.account_balance}"
    end
  end

  def balance
    account_balance
  end

  def view_active_tournaments
    Ticket.all.filter { |ticket| ticket.is_active && ticket.player_id == id }
  end

  def view_past_tournaments
    Ticket.all.filter { |ticket| ticket.!is_active && ticket.player_id == id }
  end

  def self.past_tournaments
    Tournament.all.filter { |tour| tour.!is_active }
  end

  def is_registered_for(tournament_id)
    selected_tournament_tickets = Ticket.all.filter { |ticket| ticket.tournament_id == tournament_id }
    player_ids_in_tournament = selected_tournament_tickets.map(&:player_id)
    player_ids_in_tournament.include?(id)
  end

  def reentries(tournament_id)
    current_ticket(tournament_id).reentry_number
  end

  def current_ticket(tournament_id)
    Ticket.all.filter do |ticket|
      ticket.tournament_id == tournament_id && ticket.player_id == id
    end.max_by(&:reentry_number)
  end

  def tournament_by_id(tour_id)
    Tournament.find(tour_id)
  end

  def type_by_tour_id(tour_id)
    TournamentType.find(tournament.type_id)
  end

  def calc_reg_fees
    #todo
  end

  def calc_reentry_fees
    #todo
  end

  def register(tournament_id)
    tournament = Tournament.find(tournament_id)
    type = TournamentType.find(tournament.type_id)
    total_fees = type.buy_in + type.calc_access_fee + type.calc_staff_fee
    if self.account_balance >= total_fees && !is_registered_for(tournament_id) && tournament.is_reg_open
      self.account_balance -= total_fees
      Ticket.create(player_id: id, tournament_id: tournament.id, reentry_number: 0)
      puts "You have been registered for #{type.name} on #{tournament.date_and_time}"
    elsif is_registered_for(tournament_id)
      puts "You are already registered for #{type.name}"
    else
      puts "You do not have enough money to register for #{type.name}"
    end
  end

  def reenter(tour_id)
    tournament = Tournament.find(tour_id)
    type = TournamentType.find(tour_id.type_id)
    total_fees = type.buy_in + type.calc_staff_fee
    ticket = current_ticket(tour_id)
    has_enough_money = self.account_balance >= total_fees
    has_a_ticket = !ticket.nil?
    is_reg_open = tournament.is_reg_open
    is_under_reentry_limit = ticket.nil? || reentries(tour_id) < type.max_reentries
    reentry_conditions = { has_enough_money: has_enough_money,
                           has_a_ticket: has_a_ticket,
                           is_reg_open: is_reg_open,
                           is_under_reentry_limit: is_under_reentry_limit }
    if reentry_conditions.all? { |condition| condition == true }
      self.account_balance -= total_fees
      ticket.update(is_active: false)
      Ticket.create(player_id: id, tournament_id: tournament.id,
                    reentry_number: ticket.reentry_number + 1)
      puts "You have reentered #{type.name}."
    else
      condition_false_count = 0
      reentry_conditions.each do |condition|
        condition_false_count += 1 if condition == false
      end
      if condition_false_count > 1
        puts "You are not allowed to reenter #{type.name} because of the following reasons: "
      else
        puts "You are not allowed to reenter #{type.name} because: "
      end
      display_reentry_failure_reasons(reentry_conditions)

    end
  end

  def display_reentry_failure_reasons(reentry_conditions)
    puts 'You do not have enough money to reenter.' if reentry_conditions[:has_enough_money] == false
    puts 'You do not have a ticket for this tournament.' if reentry_conditions[:has_a_ticket] == false
    puts 'Registration has ended for this tournament.' if reentry_conditions[:is_reg_open] == false
    if reentry_conditions[:is_under_reentry_limit] == false
      puts 'You have exceeded the limit of reentries for this tournament.'
    end
  end

  def cancel_registration(tournament_id)
    # TODO issue refund
    if is_registered_for(tournament_id) && reentries(tournament_id).zero? && current_ticket(tournament_id).is_active
      Ticket.destroy(current_ticket(tournament_id))
    end
  end
end
