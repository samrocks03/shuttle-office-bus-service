class Schedule < ApplicationRecord
  belongs_to :bus
  has_many :reservations, dependent: :destroy

  validates :start_point, :arrival_time, :departure_time, presence: true

  validate :arr_dept_validation

  after_initialize :set_default_available_seats

  def decrement_available_seat
    update(available_seats: available_seats - 1)
  end

  def increment_available_seat
    update(available_seats: available_seats + 1)
  end

  private

  def arr_dept_validation
    return unless arrival_time && departure_time
    errors.add(:arrival_time, "must be greater than departure time") if arrival_time <= departure_time
  end

  def set_default_available_seats
    self.available_seats ||= bus.capacity if bus
  end
end
