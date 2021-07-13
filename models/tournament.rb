
class Tournament < ActiveRecord::Base
  has_many :tickets
  has_many :players, through: :tickets


end
