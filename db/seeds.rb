# frozen_string_literal: true

PayoutLine.destroy_all

PayoutLine.create(place: 1, players_paid: 2, percent: 60)
PayoutLine.create(place: 2, players_paid: 2, percent: 40)

PayoutLine.create(place: 1, players_paid: 3, percent: 50)
PayoutLine.create(place: 2, players_paid: 3, percent: 30)
PayoutLine.create(place: 3, players_paid: 3, percent: 20)

PayoutLine.create(place: 1, players_paid: 4, percent: 45)
PayoutLine.create(place: 2, players_paid: 4, percent: 25)
PayoutLine.create(place: 3, players_paid: 4, percent: 18)
PayoutLine.create(place: 4, players_paid: 4, percent: 12)

PayoutLine.create(place: 1, players_paid: 5, percent: 40)
PayoutLine.create(place: 2, players_paid: 5, percent: 23)
PayoutLine.create(place: 3, players_paid: 5, percent: 16)
PayoutLine.create(place: 4, players_paid: 5, percent: 12)
PayoutLine.create(place: 5, players_paid: 5, percent: 9)

PayoutLine.create(place: 1, players_paid: 6, percent: 38)
PayoutLine.create(place: 2, players_paid: 6, percent: 22)
PayoutLine.create(place: 3, players_paid: 6, percent: 15)
PayoutLine.create(place: 4, players_paid: 6, percent: 11)
PayoutLine.create(place: 5, players_paid: 6, percent: 8)
PayoutLine.create(place: 6, players_paid: 6, percent: 6)

PayoutLine.create(place: 1, players_paid: 7, percent: 35)
PayoutLine.create(place: 2, players_paid: 7, percent: 21)
PayoutLine.create(place: 3, players_paid: 7, percent: 15)
PayoutLine.create(place: 4, players_paid: 7, percent: 11)
PayoutLine.create(place: 5, players_paid: 7, percent: 8)
PayoutLine.create(place: 6, players_paid: 7, percent: 6)
PayoutLine.create(place: 7, players_paid: 7, percent: 4)

PayoutLine.create(place: 1, players_paid: 8, percent: 33.5)
PayoutLine.create(place: 2, players_paid: 8, percent: 20)
PayoutLine.create(place: 3, players_paid: 8, percent: 14.5)
PayoutLine.create(place: 4, players_paid: 8, percent: 11)
PayoutLine.create(place: 5, players_paid: 8, percent: 8)
PayoutLine.create(place: 6, players_paid: 8, percent: 6)
PayoutLine.create(place: 7, players_paid: 8, percent: 4)
PayoutLine.create(place: 8, players_paid: 8, percent: 3)

PayoutLine.create(place: 1, players_paid: 9, percent: 32)
PayoutLine.create(place: 2, players_paid: 9, percent: 19.5)
PayoutLine.create(place: 3, players_paid: 9, percent: 14)
PayoutLine.create(place: 4, players_paid: 9, percent: 11)
PayoutLine.create(place: 5, players_paid: 9, percent: 8)
PayoutLine.create(place: 6, players_paid: 9, percent: 6)
PayoutLine.create(place: 7, players_paid: 9, percent: 4)
PayoutLine.create(place: 8, players_paid: 9, percent: 3)
PayoutLine.create(place: 9, players_paid: 9, percent: 2.5)

PayoutLine.create(place: 1, players_paid: 10, percent: 31.75)
PayoutLine.create(place: 2, players_paid: 10, percent: 19.25)
PayoutLine.create(place: 3, players_paid: 10, percent: 13.75)
PayoutLine.create(place: 4, players_paid: 10, percent: 10.75)
PayoutLine.create(place: 5, players_paid: 10, percent: 7.75)
PayoutLine.create(place: 6, players_paid: 10, percent: 5.75)
PayoutLine.create(place: 7, players_paid: 10, percent: 3.75)
PayoutLine.create(place: 8, players_paid: 10, percent: 3)
PayoutLine.create(place: 9, players_paid: 10, percent: 2.25)
PayoutLine.create(place: 10, players_paid: 10, percent: 2)

PayoutLine.create(place: 1, players_paid: 11, percent: 31.25)
PayoutLine.create(place: 2, players_paid: 11, percent: 19)
PayoutLine.create(place: 3, players_paid: 11, percent: 13.5)
PayoutLine.create(place: 4, players_paid: 11, percent: 10.5)
PayoutLine.create(place: 5, players_paid: 11, percent: 7.5)
PayoutLine.create(place: 6, players_paid: 11, percent: 5.5)
PayoutLine.create(place: 7, players_paid: 11, percent: 3.75)
PayoutLine.create(place: 8, players_paid: 11, percent: 3)
PayoutLine.create(place: 9, players_paid: 11, percent: 2.25)
PayoutLine.create(place: 10, players_paid: 11, percent: 2)
PayoutLine.create(place: 11, players_paid: 11, percent: 1.75)

PayoutLine.create(place: 1, players_paid: 12, percent: 30)
PayoutLine.create(place: 2, players_paid: 12, percent: 19)
PayoutLine.create(place: 3, players_paid: 12, percent: 13.25)
PayoutLine.create(place: 4, players_paid: 12, percent: 10.5)
PayoutLine.create(place: 5, players_paid: 12, percent: 7.5)
PayoutLine.create(place: 6, players_paid: 12, percent: 5.5)
PayoutLine.create(place: 7, players_paid: 12, percent: 3.75)
PayoutLine.create(place: 8, players_paid: 12, percent: 3)
PayoutLine.create(place: 9, players_paid: 12, percent: 2.25)
PayoutLine.create(place: 10, players_paid: 12, percent: 1.75)
PayoutLine.create(place: 11, players_paid: 12, percent: 1.75)
PayoutLine.create(place: 12, players_paid: 12, percent: 1.75)

Player.destroy_all
100.times do
  Player.create(first_name: Faker::Name.first_name, last_name: Faker::Name.last_name,
                join_date: Faker::Date.forward(days: rand(1..100)), account_balance: rand(50..500))
end

TournamentType.destroy_all
MAX_REENTRIES = 255
TournamentType.create(name: 'Multi Reentry Bounty', buy_in: 60, max_reentries: MAX_REENTRIES, percent_paid: 10)
TournamentType.create(name: 'More Payouts Freezeout', buy_in: 120, max_reentries: 0, percent_paid: 20)
TournamentType.create(name: 'Afternoon Turbo', buy_in: 50, max_reentries: 1, percent_paid: 12.5)
TournamentType.create(name: 'Multi Reentry', buy_in: 80, max_reentries: MAX_REENTRIES, percent_paid: 12.5)
TournamentType.create(name: 'Mega Stack Single Reentry', buy_in: 120, max_reentries: 1, percent_paid: 12.5)
TournamentType.create(name: 'Heart of Poker', buy_in: 200, max_reentries: MAX_REENTRIES, percent_paid: 12.5)
TournamentType.create(name: 'Nighttime No Time', buy_in: 80, max_reentries: 1, percent_paid: 12.5)
TournamentType.create(name: 'Sunday Super Stack', buy_in: 150, max_reentries: 1, percent_paid: 15)
