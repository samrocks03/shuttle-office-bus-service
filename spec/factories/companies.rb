FactoryBot.define do
  factory :company do
    name { Faker::Company.name }
    location { Faker::Address.city }
  end
end
