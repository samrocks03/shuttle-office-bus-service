FactoryBot.define do
  factory :bus do
    number { Faker::Vehicle.vin }
    capacity { Faker::Number.between(from: 10, to: 80) }
    model { Faker::Vehicle.model }
    company

    trait :with_schedules do
      after(:create) do |bus|
        create_list(:schedule, 5, bus: bus)
      end
    end
  end
end
