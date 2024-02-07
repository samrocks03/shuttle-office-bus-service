class CreatePayments < ActiveRecord::Migration[7.1]
  def change
    create_table :payments do |t|
      t.decimal :amount, null: false
      t.datetime :date
      t.string :method
      t.references :reservation, null: false, foreign_key: true

      t.timestamps
    end
  end
end
