# frozen_string_literal: true

class Player < ActiveRecord::Base
  has_many :tickets
  has_many :tournaments, through: :tickets

  # Existing Method from another project
  def full_name
    "#{first_name} #{last_name}"
  end

  def deposit(amount)
    self.account_balance += amount
  end

  def withdraw(amount)
    self.account_balance -= amount
  end

  def is_registered_for(tournament_id)
    selected_tournament_tickets = Ticket.all.filter { |ticket| ticket.tournament_id == tournament_id }
    player_ids_in_tournament = selected_tournament_tickets.map(&:player_id)
    player_ids_in_tournament.include?(id)
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
end
