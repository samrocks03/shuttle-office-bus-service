class AddAvailableSeatsToSchedules < ActiveRecord::Migration[7.1]
  def change
    add_column :schedules, :available_seats, :integer
  end
end
