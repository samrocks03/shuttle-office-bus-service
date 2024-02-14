# spec/factories/users.rb
FactoryBot.define do
  factory :user do
    # association :role
    association :company
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    phone_number { Faker::Number.number(digits: 10) }
    email { Faker::Internet.email }
    password { Faker::Internet.password }
    company_id {create(:company).id}
    role_id {1}

    # trait :admin do
    #   association :role, name: 'admin'
    # end

    # trait :employee do
    #   association :role, name: 'user'
    # end

    # Ensure unique email and phone_number for each user
    # sequence(:email) { |n| "#{n}_#{Faker::Internet.email}" }
    # sequence(:phone_number) { |n| "#{n}#{Faker::PhoneNumber.cell_phone}" }

    after(:build) do |user|
      user.first_name ||= Faker::Name.first_name
      user.last_name ||= Faker::Name.last_name
      user.phone_number ||= Faker::PhoneNumber.cell_phone
      user.password ||= Faker::Internet.password
    end
  end
end
