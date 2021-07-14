class AddPlaceAndPrizeToTickets < ActiveRecord::Migration[6.0]
  def change
    add_column :tickets, :place, :integer
    add_column :tickets, :prize, :integer, default: 0
  end
end
