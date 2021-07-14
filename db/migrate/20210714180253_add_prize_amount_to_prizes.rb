class AddPrizeAmountToPrizes < ActiveRecord::Migration[6.0]
  def change
    add_column :prizes, :value, :integer
  end
end
