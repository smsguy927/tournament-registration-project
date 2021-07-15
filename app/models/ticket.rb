# frozen_string_literal: true


class Ticket < ActiveRecord::Base
  belongs_to :player
  belongs_to :tournament

  # Bonus Relationships
  has_many :penalty_tickets
  has_many :penalties, through: :penalty_tickets
  
  def total_points
    PenaltyTicket.all.filter{|pt|pt.ticket_id == id}.map(&:points).sum
  end
end
