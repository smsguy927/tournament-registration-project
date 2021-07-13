# frozen_string_literal: true

class TournamentType < ActiveRecord::Base
  belongs_to :tournament

  @@access_fee_percent = 15
  @@af_one_re_upcharge = 5
  @@af_multi_re_upcharge = 10
  @@access_fee_minimum = 20
  @@staff_fee_percent = 5
  @@staff_fee_minimum = 5

  # @return [int]
  def calc_access_fee
    access_fee = buy_in * @@access_fee_percent / 100
    if max_reentries > 1
      access_fee + @@af_multi_re_upcharge
    elsif max_reentries == 1
      access_fee + @@af_one_re_upcharge
    end
    access_fee < @@access_fee_minimum ? @@access_fee_minimum : access_fee
  end

  def calc_staff_fee
    staff_fee = buy_in.round(2) * @@staff_fee_percent / 100
    staff_fee = @@staff_fee_minimum if staff_fee.zero?
    staff_fee
  end
end
