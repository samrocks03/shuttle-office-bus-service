class RemoveReservationDateFromReservation < ActiveRecord::Migration[7.1]
  def change
    remove_column :reservations, :date
  end
end
