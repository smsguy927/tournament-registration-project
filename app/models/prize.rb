# frozen_string_literal: true

class Prize < ActiveRecord::Base
  belongs_to :tournament
  belongs_to :payout_table

  def calc_place
    puts PayoutLine.all.map{|line| line.id}

    puts payout_line_id
    current_line = PayoutLine.all.find{|line|line.id == self.payout_line_id}
    current_line.place
  end
end
