class Company < ApplicationRecord
  # dependent is set to destroy, since, if i delete a company, then all has_many associations, set with it,must also get deleted

  has_many :users, dependent: :destroy
  has_many :buses, dependent: :destroy

  has_one :schedule, dependent: :destroy

  validates :name, :location, presence: true
end
