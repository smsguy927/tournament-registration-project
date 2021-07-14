# frozen_string_literal: true

class Prize < ActiveRecord::Base
  belongs_to :tournament
  belongs_to :payout_table

  def place
    PayoutLine.all.find{|line|line.id == payout_line_id}.place
  end
end
