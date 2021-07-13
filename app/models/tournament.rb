
class Tournament < ActiveRecord::Base
  has_many :tickets
  has_many :players, through: :tickets

  has_many :prizes
  has_many :payout_lines, through: :prizes

  has_many :tournament_types


end
