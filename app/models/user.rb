class User < ApplicationRecord
  belongs_to :role
  belongs_to :company
  has_many :reservations, dependent: :destroy

  validates :first_name, :last_name, :phone_number, :password_digest, presence: true
  validates :phone_number, numericality: true, format: { with: /\A\d{10}\z/, message: "must be 10 digits" }
  validates :phone_number, uniqueness: true

  before_validation :normalize_fields

  private

  def normalize_fields
    self.first_name = first_name.downcase.titleize
    self.last_name = last_name.downcase.titleize
  end
end
