class AddEmailAddressToUsersTable < ActiveRecord::Migration[7.1]
  def change
      add_column :users, :email, :text, :null => false
      change_column_default :users, :role_id, 1
    end
end
