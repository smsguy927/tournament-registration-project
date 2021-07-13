class AddFlagsToTournaments < ActiveRecord::Migration[6.0]
  def change
    add_column :tournaments, :is_reg_open, :boolean, default: true
    add_column :tournaments, :is_active, :boolean, default: true
  end
end
