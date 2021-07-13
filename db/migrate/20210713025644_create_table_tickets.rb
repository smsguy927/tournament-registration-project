class CreateTableTickets < ActiveRecord::Migration[6.0]
  def change
    create_table :tickets do |t|
      t.integer :player_id
      t.integer :tournament_id
      t.integer :reentry_number
    end
  end
end
