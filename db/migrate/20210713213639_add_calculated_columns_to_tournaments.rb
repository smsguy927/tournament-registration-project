class AddCalculatedColumnsToTournaments < ActiveRecord::Migration[6.0]
  def change
    change_column(:tournaments, :extra_prizepool, :integer, default: 0)
    add_column :tournaments, :total_players, :integer, default: 0
    add_column :tournaments, :remaining_players, :integer, default: 0
    add_column :tournaments, :total_prizepool, :integer, default: 0
    add_column :tournaments, :places_paid, :integer, default: 0
  end
end
