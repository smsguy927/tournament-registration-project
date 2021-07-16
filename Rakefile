

require_relative 'config/environment.rb'
require "sinatra/activerecord/rake"

desc "start console"
task :console do

  t14 = Tournament.find(14)
  t14.close_registration
  while t14.remaining_players > 0
    t14.knockout_player(t14.active_player_ids.sample)
  end

  #Pry.start
end



