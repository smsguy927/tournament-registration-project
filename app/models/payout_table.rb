# frozen_string_literal: true

class PayoutTable < ActiveRecord::Base
  has_many :prizes
  has_many :payout_tables, through: :prizes
end
