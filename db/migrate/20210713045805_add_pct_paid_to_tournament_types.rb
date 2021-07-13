# frozen_string_literal: true

class AddPctPaidToTournamentTypes < ActiveRecord::Migration[6.0]
  def change
    add_column :tournament_types, :percent_paid, :decimal, precision: 4, scale: 2, after: :max_reentries
  end
end
