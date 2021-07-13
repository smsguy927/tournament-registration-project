class CreateTablePenaltyTickets < ActiveRecord::Migration[6.0]
  def change
    create_table :penalty_tickets do |t|
      t.integer :ticket_id
      t.integer :penalty_id
    end
  end
end
