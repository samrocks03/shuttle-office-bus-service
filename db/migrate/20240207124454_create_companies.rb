class CreateCompanies < ActiveRecord::Migration[7.1]
  def change
    create_table :companies do |t|
      t.string :name, null: false
      t.string :location, null: false
      t.references :user, null: false, foreign_key: true
      t.timestamps
    end
  end
end
