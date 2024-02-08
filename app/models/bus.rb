class Bus < ApplicationRecord
  has_many :schedules
  belongs_to :company

  validates :number, :capacity, :model, presence: true
  validates :normalize_model, presence: true

  private

  def normalize_model
    self.model = model.downcase.titleize
  end
end
