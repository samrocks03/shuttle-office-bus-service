class CreateUsers < ActiveRecord::Migration[7.1]
  def change
    create_table :users do |t|
      t.string :first_name, null: false
      t.string :last_name, null: false
      t.string :phone_number, null: false

      t.references :company, :role, null: false, foreign_key: true
      t.timestamps
    end
  end
end
