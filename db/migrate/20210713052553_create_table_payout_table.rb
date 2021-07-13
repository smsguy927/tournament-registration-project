class CreateTablePayoutTable < ActiveRecord::Migration[6.0]
  def change
    create_table :payout_table do |t|
      t.integer :place
      t.integer :players_paid
      t.decimal :percent, precision: 4, scale: 2
    end
  end
end
