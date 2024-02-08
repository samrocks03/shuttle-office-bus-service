class Company < ApplicationRecord
  has_many :users
  has_many :buses
  has_one :schedule

  validates :name, :location, presence: true
end
