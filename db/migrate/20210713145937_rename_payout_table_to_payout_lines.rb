class RenamePayoutTableToPayoutLines < ActiveRecord::Migration[6.0]
  def change
    rename_table :payout_table, :payout_lines
  end
end
