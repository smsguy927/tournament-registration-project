# frozen_string_literal: true

class TournamentType < ActiveRecord::Base
  belongs_to :tournament
  # TODO: add methods to calculate access fee and dealer appreciation
end
