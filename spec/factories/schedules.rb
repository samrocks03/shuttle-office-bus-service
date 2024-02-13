FactoryBot.define do
  factory :schedule do
    association :bus
    start_point { Faker::Address.city }
    arrival_time { Faker::Time.forward(days: 7, period: :evening) }
    departure_time { Faker::Time.forward(days: 7, period: :morning) }
    available_seats { bus&.capacity || Faker::Number.between(from: 10, to: 50) }
    date { Faker::Date.forward(days: 7) }

    after(:build) do |schedule|
      schedule.bus ||= create(:bus)
    end

    trait :with_reservations do
      after(:create) do |schedule|
        create_list(:reservation, 5, schedule: schedule)
      end
    end
  end
end
