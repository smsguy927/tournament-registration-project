class CreateTableTournamentTypes < ActiveRecord::Migration[6.0]
  def change
    create_table :tournament_types do |t|
      t.string :name
      t.integer :buy_in
      t.integer :max_reentries
    end
  end
end