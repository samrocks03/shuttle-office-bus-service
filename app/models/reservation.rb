class Reservation < ApplicationRecord
  belongs_to :user
  belongs_to :schedule
  has_one :payment

  validates :schedule_id, :user_id, presence: true
end
