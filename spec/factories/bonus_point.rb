FactoryBot.define do
  factory :bonus_point do
    name { Faker::Lorem.word }
    lon { rand * 10 }
    lat { rand * 20 }
    points { rand(15) }

    event
  end
end
