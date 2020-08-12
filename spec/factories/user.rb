FactoryBot.define do
  factory :user do
    sequence(:email) { |n| "test_#{n}@example.com" }
    password { 'password' }
    name { Faker::Name.name }
    nickname { Faker::Name.name }

    trait :with_phone do
      phone_number { '+48 732 258 640' }
      send_messages { true }
      send_riddles { true }
    end
  end
end
