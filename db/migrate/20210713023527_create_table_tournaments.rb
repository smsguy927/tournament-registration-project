class CreateTableTournaments < ActiveRecord::Migration[6.0]
  def change
    create_table :tournaments do |t|
      t.datetime :date_and_time
      t.integer :type_id
    end
  end
end
