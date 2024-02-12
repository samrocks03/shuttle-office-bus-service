class RemoveColumnsFromSchedules < ActiveRecord::Migration[7.1]
  def change
    remove_column :schedules, :arrival_hour
    remove_column :schedules, :arrival_minute
    remove_column :schedules, :departure_hour
    remove_column :schedules, :departure_minute

    add_column :schedules, :arrival_time, :time
    add_column :schedules, :departure_time, :time

  end
end
