class CreateSchedules < ActiveRecord::Migration[7.1]
  def change
    create_table :schedules do |t|
      t.text :start_point

      t.integer :arrival_minute
      t.integer :arrival_hour

      t.integer :departure_minute
      t.integer :departure_hour

      t.references :bus, null: false, foreign_key: true
      t.references :company, null: false, foreign_key: true

      t.timestamps
    end
  end
end
