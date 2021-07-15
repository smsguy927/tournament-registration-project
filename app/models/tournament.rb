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

  def calculate_remaining_players
    Ticket.all.filter { |ticket| ticket.tournament_id == id && ticket.is_active }.length
  end

  def calculate_total_prizepool
    update(extra_prizepool: 0) if extra_prizepool.nil?
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
    payout_line(place).percent * total_prizepool / 100.round.to_i
  end

  def make_prize(line_id, value)
    Prize.create(tournament_id: id, payout_line_id: line_id, value: value)
  end

  def make_all_prizes
    i = 1
    while i < places_paid + 1
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
    found_prize = Prize.all.find { |prize| prize.place == place }
    found_prize&.value
  end

  def place_str(count)
    first = 1
    second = 2
    third = 3
    if count == first
      '1st: $'
    elsif count == second
      '2nd: $'
    elsif count == third
      '3rd: $'
    else
      "#{count}th: $"
    end
  end

  def display_places_paid
    i = 1
    while i < places_paid + 1
      prize_value = calc_prize_value(i)
      puts place_str(i) + prize_value.to_s
      i += 1
    end
  end

  def announce_reg_closed
    # TODO: need to fix the way this is displayed
    puts <<~HEREDOC
      Registration for #{tournament_name} has closed. There were #{total_players} entries. The total prizepool is
      $#{total_prizepool}. We are paying the top #{places_paid} places. First place will win $#{first_place} all
      the way down to a min cash of $#{min_cash}. There are #{remaining_players} of you left. Good luck the rest
      of the way. All of the tournament stats will be accurate from this point forward.#{' '}
    HEREDOC
    display_places_paid
  end

  def close_registration
    update(is_reg_open: false)
    update(total_players: calculate_total_players)
    update(remaining_players: calculate_remaining_players)
    update(total_prizepool: calculate_total_prizepool)
    update(places_paid: calculate_places_paid)
    make_all_prizes
    announce_reg_closed
  end

  def self.display_tournaments
    Tournament.all.map do |tournament|
      "ID: #{tournament.id} | Date: #{tournament.date_and_time} | #{tournament.tournament_name}
      | Buy in : #{tournament.buy_in} | Re-entries: #{tournament.max_reentries}
      | Percent Paid #{tournament.percent_paid}"
    end
  end

  def self.display_types
    TournamentType.all.map do |type|
      "ID: #{type.id} | #{type.name} | Buy in : #{type.buy_in} | Re-entries: #{type.max_reentries}
      | Percent Paid #{type.percent_paid}"
    end
  end
end
