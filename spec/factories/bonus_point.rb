FactoryBot.define do
  factory :bonus_point do
    name { Faker::Lorem.word }
    lng { 0.0 }
    lat { 0.0 }

    event
  end
end
