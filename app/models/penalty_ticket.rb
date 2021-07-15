class PenaltyTicket < ActiveRecord::Base
  belongs_to :ticket
  belongs_to :penalty

  def points
    Penalty.find(penalty_id).points
  end

  def name
    Penalty.find(penalty_id).name
  end
end