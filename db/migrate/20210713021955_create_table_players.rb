class CreateTablePlayers < ActiveRecord::Migration[6.0]
  def change
    create_table :players do |t|
      t.string :first_name
      t.string :last_name
      t.date :join_date
      t.integer :account_balance
    end
  end
end
