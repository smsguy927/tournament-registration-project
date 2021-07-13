# frozen_string_literal: true

class PayoutLine < ActiveRecord::Base
  has_many :prizes
  has_many :tournaments, through: :prizes
end
