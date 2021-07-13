# frozen_string_literal: true

class Tournament < ActiveRecord::Base
  has_many :tickets
  has_many :players, through: :tickets

  has_many :prizes
  has_many :payout_lines, through: :prizes

  has_many :tournament_types

  def tournament_name
    TournamentType.find(type_id).name
  end

  def buy_in
    TournamentType.find(type_id).buy_in
  end

  def max_reentries
    TournamentType.find(type_id).max_reentries
  end

  def percent_paid
    TournamentType.find(type_id).percent_paid
  end

  def calculate_total_players
    Ticket.all.filter{|ticket| ticket.tournament_id == self.id}.length
  end

  def calculate_total_prizepool
    calculate_total_players * buy_in + extra_prizepool
  end

  def calculate_places_paid
    min_places_paid = 2
    max_places_paid = 12

    places_paid = calculate_total_players * percent_paid
    if places_paid < min_places_paid
      places_paid = min_places_paid
    end
    if places_paid > max_places_paid
      places_paid = max_places_paid
    end
    places_paid
  end

  def close_registration
    is_reg_open.update(false)
    total_players.update(calculate_total_players)
    total_prizepool.update(calculate_total_prizepool)
    places_paid.update(calculate_places_paid)
  end

  def self.display_tournaments
    Tournament.all.map do |tournament|
      "ID: #{tournament.id} | Date: #{tournament.date_and_time} | #{tournament.tournament_name} | Buy in : #{tournament.buy_in} | Re-entries: #{tournament.max_reentries} | Percent Paid #{tournament.percent_paid}"
    end
  end
end
