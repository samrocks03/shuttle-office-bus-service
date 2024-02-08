class Schedule < ApplicationRecord
  belongs_to :bus
  belongs_to :company
  has_many :reservations


  validates :start_point, :arrival_minute, :arrival_hour, :departure_minute, :departure_hour, presence: true

  validates :departure_hour, presence: true, numericality: { only_integer: true, less_than_or_equal_to: 23, greater_than_or_equal_to: 0 }

  validates :departure_minute, presence: true, numericality: { only_integer: true, less_than_or_equal_to: 59, greater_than_or_equal_to: 0 }

  validates :arrival_hour, presence: true, numericality: { only_integer: true, less_than_or_equal_to: 23, greater_than_or_equal_to: 0 }

  validates :arrival_minute, presence: true, numericality: { only_integer: true, less_than_or_equal_to: 59, greater_than_or_equal_to: 0 }



end
