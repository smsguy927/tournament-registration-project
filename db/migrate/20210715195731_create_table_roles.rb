class CreateTableRoles < ActiveRecord::Migration[6.0]
  def change
    create_table :roles do |t|
      t.string :name
    end
  end
end
