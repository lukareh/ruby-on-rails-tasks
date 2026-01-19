# factory for creating user test data
FactoryBot.define do
  factory :user do
    name { Faker::Name.name }
    email { Faker::Internet.email }
    password { 'password123' }
    password_confirmation { 'password123' }
    admin { false }

    # trait for admin user
    trait :admin do
      admin { true }
    end
  end
end
