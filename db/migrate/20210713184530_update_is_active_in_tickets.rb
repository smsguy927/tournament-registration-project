class UpdateIsActiveInTickets < ActiveRecord::Migration[6.0]
  def change
    change_column(:tickets, :is_active, :boolean, default: true)
  end
end
