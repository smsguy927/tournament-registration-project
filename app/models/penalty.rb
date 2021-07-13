class Penalty < ActiveRecord::Base
  has_many :penalty_tickets
  has_many :tickets, through: :penalty_tickets
end