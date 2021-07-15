class AddRemainingPrizepoolToTournaments < ActiveRecord::Migration[6.0]
  def change
    add_column :tournaments, :remaining_prizepool, :integer, default: 0
  end
end
