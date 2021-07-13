class PenaltyTicket < ActiveRecord::Base
  belongs_to :ticket
  belongs_to :penalty
end