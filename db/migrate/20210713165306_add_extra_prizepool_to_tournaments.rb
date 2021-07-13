class AddExtraPrizepoolToTournaments < ActiveRecord::Migration[6.0]
  def change
    add_column :tournaments, :extra_prizepool, :integer
  end
end
