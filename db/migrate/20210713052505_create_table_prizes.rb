class CreateTablePrizes < ActiveRecord::Migration[6.0]
  def change
    create_table :prizes do |t|
      t.integer :tournament_id
      t.integer :payout_table_id
    end
  end
end
