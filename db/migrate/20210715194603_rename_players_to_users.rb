class RenamePlayersToUsers < ActiveRecord::Migration[6.0]
  def change
    rename_table :players, :users
  end
end
