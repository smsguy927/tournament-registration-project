class CreateTablePenalties < ActiveRecord::Migration[6.0]
  def change
    create_table :penalties do |t|
      t.string :name
      t.integer :points
    end
  end
end
