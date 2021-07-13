# frozen_string_literal: true


class Ticket < ActiveRecord::Base
  belongs_to :player
  belongs_to :tournament

  # Bonus Relationships
  has_many :penalty_tickets
  has_many :penalties, through: :penalty_tickets
end
