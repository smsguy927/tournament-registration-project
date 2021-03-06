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

  def active_tournaments
    Ticket.all.filter { |ticket| ticket.is_active && ticket.player_id == id }
  end

  def past_tournaments
    Ticket.all.filter { |ticket| !ticket.is_active && ticket.player_id == id }
  end

  def past_cashes
    past_tournaments.filter{ |ticket| ticket.prize.positive? }
  end

  def self.past_tournaments
    Tournament.all.filter { |tour| tour.!is_active }
  end

  def registered_for?(tournament_id)
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

  def tournament(tour_id)
    Tournament.find_by(id: tour_id)
  end

  def type_by_tour_id(tour_id)
    TournamentType.find(Tournament.find(tour_id).type_id)
  end

  def total_reg_price(tour_id)
    type = type_by_tour_id(tour_id)
    type.buy_in + type.calc_reg_fee
  end

  def total_reentry_price(tour_id)
    type = type_by_tour_id(tour_id)
    type.buy_in + type.calc_staff_fee
  end

  def issue_refund(tour_id)
    type = type_by_tour_id(tour_id)
    refund_amount = type.buy_in + type.calc_reg_fee
    update(account_balance: balance + refund_amount)
  end

  def can_register(tour_id)
    self.account_balance >= total_reg_price(tour_id) && !registered_for?(tour_id) && tournament(tour_id).is_reg_open
  end

  def register(tour_id)
    type = type_by_tour_id(tour_id)
    if can_register(tour_id)
      pass_registration(tour_id, type)
    else
      fail_registration(tour_id, type)
    end
  end

  def pass_registration(tour_id, type)
    withdraw(total_reg_price(tour_id))
    Ticket.create(player_id: id, tournament_id: tour_id, reentry_number: 0)
    puts "You have been registered for #{type.name} on #{tournament(tour_id).date_and_time}"
  end

  def fail_registration(tour_id, type)
    if registered_for?(tour_id)
      puts "You are already registered for #{type.name}"
    else
      puts "You do not have enough money to register for #{type.name}"
    end
  end

  def reenter(tour_id)
    type = type_by_tour_id(tour_id)
    total_fees = type.buy_in + type.calc_staff_fee
    reentry_conditions = make_reentry_conditions(tour_id, type)
    if reentry_conditions.values.all? { |condition| condition == true }
      pass_reentry(total_fees)
    else
      fail_reentry(reentry_conditions, type)
    end
  end

  def make_reentry_conditions(tour_id, type)
    {
      has_enough_money: account_balance >= total_reentry_price(tour_id),
      has_a_ticket: !current_ticket(tour_id).nil?,
      is_reg_open: tournament(tour_id).is_reg_open,
      is_under_reentry_limit: current_ticket(tour_id).nil? || reentries(tour_id) < type.max_reentries
    }
  end

  def pass_reentry(total_fees)
    self.account_balance -= total_fees
    ticket&.update(is_active: false)
    Ticket.create(player_id: id, tournament_id: tournament.id,
                  reentry_number: ticket && ticket.reentry_number + 1)
    puts "You have reentered #{type.name}."
  end

  def fail_reentry(reentry_conditions, type)
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

  def display_reentry_failure_reasons(reentry_conditions)
    puts 'You do not have enough money to reenter.' if reentry_conditions[:has_enough_money] == false
    puts 'You do not have a ticket for this tournament.' if reentry_conditions[:has_a_ticket] == false
    puts 'Registration has ended for this tournament.' if reentry_conditions[:is_reg_open] == false
    if reentry_conditions[:is_under_reentry_limit] == false
      puts 'You have exceeded the limit of reentries for this tournament.'
    end
  end

  def cancel_registration(tournament_id)
    if registered_for?(tournament_id) && reentries(tournament_id).zero? && current_ticket(tournament_id).is_active
      Ticket.destroy(current_ticket(tournament_id))
      issue_refund(tournament_id)
    end
  end
end
