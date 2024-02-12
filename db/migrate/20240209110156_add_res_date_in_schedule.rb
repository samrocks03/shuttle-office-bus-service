class AddResDateInSchedule < ActiveRecord::Migration[7.1]
  def change
    add_column :schedules, :date, :date
    remove_column :schedules, :company_id
  end
end
