class Payment < ApplicationRecord
  belongs_to :reservation

  validates :amount, presence: true

end
