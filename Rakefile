

require_relative 'config/environment.rb'
require "sinatra/activerecord/rake"

desc "start console"
task :console do
  #p122 = User.find_by(id: 212)
  #p122.reenter(5)
  #p122.view_active_tournaments
  #p122.view_past_tournaments

  t5 = Tournament.find_by(id: 5)
  puts t5.active_player_ids
  t5.knockout_player(201)
  puts 'end'
  Pry.start
end

task :add_penalties do
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
end
