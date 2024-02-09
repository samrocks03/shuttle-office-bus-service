class Schedule < ApplicationRecord
  belongs_to :bus
  # belongs_to :company
  has_many :reservations, dependent: :destroy

  #this will give me all required presence validations as true
  validates :start_point, :arrival_time, :departure_time, presence: true
end
