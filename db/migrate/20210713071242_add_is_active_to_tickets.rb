class AddIsActiveToTickets < ActiveRecord::Migration[6.0]
  def change
    add_column :tickets, :is_active, :boolean
  end
end
