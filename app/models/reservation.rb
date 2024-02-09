class Reservation < ApplicationRecord
  belongs_to :user
  belongs_to :schedule
  has_one :payment

  validates :date, presence: true
end
