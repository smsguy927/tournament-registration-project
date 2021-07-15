

require_relative 'config/environment.rb'
require "sinatra/activerecord/rake"

desc "start console"
task :console do
  #p122 = Player.find_by(id: 212)
  #p122.reenter(5)
  #p122.view_active_tournaments
  #p122.view_past_tournaments

  t5 = Tournament.find_by(id: 5)
  puts t5.active_player_ids
  t5.knockout_player(201)
  puts 'end'
  Pry.start
end