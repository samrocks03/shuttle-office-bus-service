class Payment < ApplicationRecord
  belongs_to :reservation

  validates :amount, presence: true
  validates :method, inclusion: {in: %w(Online Cash),
  message: "%{value} is not a valid payment method"}

  before_validation :normalise


  private

  def normalise
    self.payment_mode = payment_mode.downcase.titleize
  end

end
