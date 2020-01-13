FactoryBot.define do
  factory :user do
    sequence(:email) { |n| "test_#{n}@example.com" }
    password { 'password' }
    name { Faker::Name.name }
    nickname { Faker::Name.name }
  end
end
