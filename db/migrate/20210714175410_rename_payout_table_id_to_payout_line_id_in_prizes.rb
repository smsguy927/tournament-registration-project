class RenamePayoutTableIdToPayoutLineIdInPrizes < ActiveRecord::Migration[6.0]
  def change
    rename_column(:prizes, :payout_table_id, :payout_line_id)
  end
end
