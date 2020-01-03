FactoryBot.define do
  factory :challenge do
    event

    title { Faker::Lorem.word }
    description { Faker::Lorem.words(10).join(' ') }
    points { 5 }
  end
end
