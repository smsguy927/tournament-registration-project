# frozen_string_literal: true

PayoutLine.destroy_all

PayoutLine.create(place: 1, places_paid: 2, percent: 60)
PayoutLine.create(place: 2, places_paid: 2, percent: 40)

PayoutLine.create(place: 1, places_paid: 3, percent: 50)
PayoutLine.create(place: 2, places_paid: 3, percent: 30)
PayoutLine.create(place: 3, places_paid: 3, percent: 20)

PayoutLine.create(place: 1, places_paid: 4, percent: 45)
PayoutLine.create(place: 2, places_paid: 4, percent: 25)
PayoutLine.create(place: 3, places_paid: 4, percent: 18)
PayoutLine.create(place: 4, places_paid: 4, percent: 12)

PayoutLine.create(place: 1, places_paid: 5, percent: 40)
PayoutLine.create(place: 2, places_paid: 5, percent: 23)
PayoutLine.create(place: 3, places_paid: 5, percent: 16)
PayoutLine.create(place: 4, places_paid: 5, percent: 12)
PayoutLine.create(place: 5, places_paid: 5, percent: 9)

PayoutLine.create(place: 1, places_paid: 6, percent: 38)
PayoutLine.create(place: 2, places_paid: 6, percent: 22)
PayoutLine.create(place: 3, places_paid: 6, percent: 15)
PayoutLine.create(place: 4, places_paid: 6, percent: 11)
PayoutLine.create(place: 5, places_paid: 6, percent: 8)
PayoutLine.create(place: 6, places_paid: 6, percent: 6)

PayoutLine.create(place: 1, places_paid: 7, percent: 35)
PayoutLine.create(place: 2, places_paid: 7, percent: 21)
PayoutLine.create(place: 3, places_paid: 7, percent: 15)
PayoutLine.create(place: 4, places_paid: 7, percent: 11)
PayoutLine.create(place: 5, places_paid: 7, percent: 8)
PayoutLine.create(place: 6, places_paid: 7, percent: 6)
PayoutLine.create(place: 7, places_paid: 7, percent: 4)

PayoutLine.create(place: 1, places_paid: 8, percent: 33.5)
PayoutLine.create(place: 2, places_paid: 8, percent: 20)
PayoutLine.create(place: 3, places_paid: 8, percent: 14.5)
PayoutLine.create(place: 4, places_paid: 8, percent: 11)
PayoutLine.create(place: 5, places_paid: 8, percent: 8)
PayoutLine.create(place: 6, places_paid: 8, percent: 6)
PayoutLine.create(place: 7, places_paid: 8, percent: 4)
PayoutLine.create(place: 8, places_paid: 8, percent: 3)

PayoutLine.create(place: 1, places_paid: 9, percent: 32)
PayoutLine.create(place: 2, places_paid: 9, percent: 19.5)
PayoutLine.create(place: 3, places_paid: 9, percent: 14)
PayoutLine.create(place: 4, places_paid: 9, percent: 11)
PayoutLine.create(place: 5, places_paid: 9, percent: 8)
PayoutLine.create(place: 6, places_paid: 9, percent: 6)
PayoutLine.create(place: 7, places_paid: 9, percent: 4)
PayoutLine.create(place: 8, places_paid: 9, percent: 3)
PayoutLine.create(place: 9, places_paid: 9, percent: 2.5)

PayoutLine.create(place: 1, places_paid: 10, percent: 31.75)
PayoutLine.create(place: 2, places_paid: 10, percent: 19.25)
PayoutLine.create(place: 3, places_paid: 10, percent: 13.75)
PayoutLine.create(place: 4, places_paid: 10, percent: 10.75)
PayoutLine.create(place: 5, places_paid: 10, percent: 7.75)
PayoutLine.create(place: 6, places_paid: 10, percent: 5.75)
PayoutLine.create(place: 7, places_paid: 10, percent: 3.75)
PayoutLine.create(place: 8, places_paid: 10, percent: 3)
PayoutLine.create(place: 9, places_paid: 10, percent: 2.25)
PayoutLine.create(place: 10, places_paid: 10, percent: 2)

PayoutLine.create(place: 1, places_paid: 11, percent: 31.25)
PayoutLine.create(place: 2, places_paid: 11, percent: 19)
PayoutLine.create(place: 3, places_paid: 11, percent: 13.5)
PayoutLine.create(place: 4, places_paid: 11, percent: 10.5)
PayoutLine.create(place: 5, places_paid: 11, percent: 7.5)
PayoutLine.create(place: 6, places_paid: 11, percent: 5.5)
PayoutLine.create(place: 7, places_paid: 11, percent: 3.75)
PayoutLine.create(place: 8, places_paid: 11, percent: 3)
PayoutLine.create(place: 9, places_paid: 11, percent: 2.25)
PayoutLine.create(place: 10, places_paid: 11, percent: 2)
PayoutLine.create(place: 11, places_paid: 11, percent: 1.75)

PayoutLine.create(place: 1, places_paid: 12, percent: 30)
PayoutLine.create(place: 2, places_paid: 12, percent: 19)
PayoutLine.create(place: 3, places_paid: 12, percent: 13.25)
PayoutLine.create(place: 4, places_paid: 12, percent: 10.5)
PayoutLine.create(place: 5, places_paid: 12, percent: 7.5)
PayoutLine.create(place: 6, places_paid: 12, percent: 5.5)
PayoutLine.create(place: 7, places_paid: 12, percent: 3.75)
PayoutLine.create(place: 8, places_paid: 12, percent: 3)
PayoutLine.create(place: 9, places_paid: 12, percent: 2.25)
PayoutLine.create(place: 10, places_paid: 12, percent: 1.75)
PayoutLine.create(place: 11, places_paid: 12, percent: 1.75)
PayoutLine.create(place: 12, places_paid: 12, percent: 1.75)



TournamentType.destroy_all
MAX_REENTRIES = 255
multi_reentry_bounty = TournamentType.create(name: 'Multi Reentry Bounty', buy_in: 60, max_reentries: MAX_REENTRIES, percent_paid: 10)
more_payouts_freezeout = TournamentType.create(name: 'More Payouts Freezeout', buy_in: 120, max_reentries: 0, percent_paid: 20)
afternoon_turbo = TournamentType.create(name: 'Afternoon Turbo', buy_in: 50, max_reentries: 1, percent_paid: 12.5)
wacky_wednesday_freeroll = TournamentType.create(name: 'Wacky Wednesday Freeroll', buy_in: 0, max_reentries: 0, percent_paid: 15)
double_stack = TournamentType.create(name: 'Double Stack', buy_in: 80, max_reentries: 0, percent_paid: 15)
multi_reentry = TournamentType.create(name: 'Multi Reentry', buy_in: 80, max_reentries: MAX_REENTRIES, percent_paid: 12.5)
mega_stack_single_reentry = TournamentType.create(name: 'Mega Stack Single Reentry', buy_in: 120, max_reentries: 1, percent_paid: 12.5)
heart_of_poker = TournamentType.create(name: 'Heart of Poker', buy_in: 200, max_reentries: MAX_REENTRIES, percent_paid: 12.5)
nighttime_no_time = TournamentType.create(name: 'Nighttime No Time', buy_in: 80, max_reentries: 1, percent_paid: 12.5)
sunday_super_stack = TournamentType.create(name: 'Sunday Super Stack', buy_in: 150, max_reentries: 1, percent_paid: 15)

Tournament.destroy_all
AFTERNOON_START = '13:15'
EVENING_START = '19:15'
SPECIAL_START = '12:15'
Tournament.create(date_and_time: "2021-07-19 #{AFTERNOON_START}", type_id: multi_reentry_bounty.id)
Tournament.create(date_and_time: "2021-07-20 #{AFTERNOON_START}", type_id: afternoon_turbo.id)
Tournament.create(date_and_time: "2021-07-21 #{AFTERNOON_START}", type_id: double_stack.id)
Tournament.create(date_and_time: "2021-07-22 #{AFTERNOON_START}", type_id: multi_reentry.id)
Tournament.create(date_and_time: "2021-07-23 #{AFTERNOON_START}", type_id: multi_reentry_bounty.id)
Tournament.create(date_and_time: "2021-07-24 #{SPECIAL_START}", type_id: heart_of_poker.id)
Tournament.create(date_and_time: "2021-07-25 #{AFTERNOON_START}", type_id: sunday_super_stack.id)
Tournament.create(date_and_time: "2021-07-19 #{EVENING_START}", type_id: nighttime_no_time.id)
Tournament.create(date_and_time: "2021-07-20 #{EVENING_START}", type_id: more_payouts_freezeout.id)
Tournament.create(date_and_time: "2021-07-21 #{EVENING_START}", type_id: wacky_wednesday_freeroll.id)
Tournament.create(date_and_time: "2021-07-22 #{EVENING_START}", type_id: mega_stack_single_reentry.id)
Tournament.create(date_and_time: "2021-07-23 #{EVENING_START}", type_id: more_payouts_freezeout.id)
Tournament.create(date_and_time: "2021-07-24 #{EVENING_START}", type_id: mega_stack_single_reentry.id)
test_tour = Tournament.create(date_and_time: "2021-07-25 #{EVENING_START}", type_id: nighttime_no_time.id)

Penalty.destroy_all
Penalty.create(name: 'Acting Out of Turn', points: 2)
Penalty.create(name: 'Exposing Cards With Action Pending', points: 2)
Penalty.create(name: 'Premature Exposing Cards During Hand for Hand', points: 5)
Penalty.create(name: 'Folding to no Action', points: 3)
Penalty.create(name: 'Starting in the Wrong Seat', points: 3)
Penalty.create(name: 'Leaving the Table With Action Pending', points: 4)
Penalty.create(name: 'Leaving the Table With Action Pending Before a Break', points: 6)
Penalty.create(name: 'Rabbit Hunting', points: 7)
Penalty.create(name: 'Dodging Blinds', points: 7)
Penalty.create(name: 'Discarding Hand During All-In Showdown', points: 5)
Penalty.create(name: 'Splashing the Pot', points: 2)
Penalty.create(name: 'Failure to Keep Cards Visible', points: 4)
Penalty.create(name: 'Failure to Keep High Denomination Chips Visible', points: 5)
Penalty.create(name: 'Throwing Cards off the Table', points: 8)
Penalty.create(name: 'Excessive Foul Language', points: 5)
Penalty.create(name: 'Super Excessive Foul Language', points: 10)
Penalty.create(name: 'Soft Playing', points: 11)
Penalty.create(name: 'Chip Dumping', points: 12)
Penalty.create(name: 'Collusion', points: 12)
Penalty.create(name: 'Cheating', points: 12)
Penalty.create(name: 'Playing in the Wrong Tournament', points: 12)
Penalty.create(name: 'Failure to Keep Chips Visible When Transferring Tables', points: 10)

Role.destroy_all
Role.create(name: 'Player', id: 1)
Role.create(name: 'Dealer', id: 2)
Role.create(name: 'Manager', id: 3)
Role.create(name: 'Banned', id: 0)


User.destroy_all
67.times do
  new_user = User.create(first_name: Faker::Name.first_name, last_name: Faker::Name.last_name,
                         join_date: Faker::Date.forward(days: rand(1..100)), account_balance: rand(100..500))
  new_user.register(test_tour.id)
end
puts 'All done seeding'

