FactoryBot.define do
  factory :reservation do
    association :user
    association :schedule
  end
end
