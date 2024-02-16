class Reservation < ApplicationRecord
  belongs_to :user
  belongs_to :schedule
  # has_one :payment

  validates :schedule_id, :user_id, presence: true
  validates :schedule_id, uniqueness: { scope: :user_id, message: "is already booked " }

end
