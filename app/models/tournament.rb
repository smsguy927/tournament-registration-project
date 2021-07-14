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
    Ticket.all.filter { |ticket| ticket.tournament_id == id }.length
  end

  def calculate_total_prizepool
    calculate_total_players * buy_in + extra_prizepool
  end

  def calculate_places_paid
    min_places_paid = 2
    max_places_paid = 12

    places_paid = calculate_total_players * percent_paid
    places_paid = min_places_paid if places_paid < min_places_paid
    places_paid = max_places_paid if places_paid > max_places_paid
    places_paid
  end

  def payout_line(place)
    PayoutLine.all.find { |line| line.place == place && line.places_paid == places_paid }
  end

  def calc_prize_value(place)
    payout_line(place).percent * total_prizepool
  end

  def make_prize(line_id, value)
    Prize.create(tournament_id: id, payout_line_id: line_id, value: value)
  end

  def make_all_prizes
    i = 1
    while i < places_paid
      make_prize(payout_line(i).id, calc_prize_value(i))
      i += 1
    end
  end

  def first_place
    prize_value(1)
  end

  def min_cash
    prize_value(places_paid)
  end

  def prize_value(place)
    Prize.all.find{|prize| prize.place == place}.value
  end

  def display_places_paid
    first = 1
    second = 2
    third = 3
    i = 1
    while i < places_paid
      if i == first
        puts '1st: $'
      elsif i == second
        puts '| 2nd: $'
      elsif i == third
        puts '| 3rd: $'
      else
        puts "| #{i}th: $"
      end
      prize_value = calc_prize_value(i)
      puts prize_value
      i += 1
    end
  end

  def announce_reg_closed
    puts "Registration for #{tournament_name} has closed. There were #{total_players} entries. The total prizepool is \
          $#{total_prizepool}. We are paying the top #{places_paid} places. First place will win $#{first_place} all \
          the way down to a min cash of #{min_cash}. There are #{remaining_players} of you left. Good luck the rest \
          of the way. All of the tournament stats will be accurate from this point forward."
    display_places_paid
  end

  def close_registration
    is_reg_open.update(false)
    total_players.update(calculate_total_players)
    total_prizepool.update(calculate_total_prizepool)
    places_paid.update(calculate_places_paid)
    make_all_prizes
    announce_reg_closed
  end

  def self.display_tournaments
    Tournament.all.map do |tournament|
      "ID: #{tournament.id} | Date: #{tournament.date_and_time} | #{tournament.tournament_name} \
      | Buy in : #{tournament.buy_in} | Re-entries: #{tournament.max_reentries} \
      | Percent Paid #{tournament.percent_paid}"
    end
  end
end
