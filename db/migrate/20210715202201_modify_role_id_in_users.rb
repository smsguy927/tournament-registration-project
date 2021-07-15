class ModifyRoleIdInUsers < ActiveRecord::Migration[6.0]
  def change
    change_column(:users, :role_id, :integer, default: 1)
  end
end
