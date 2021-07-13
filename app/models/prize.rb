# frozen_string_literal: true

class Prize < ActiveRecord::Base
  belongs_to :tournament
  belongs_to :payout_table
end
