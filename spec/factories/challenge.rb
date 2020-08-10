FactoryBot.define do
  factory :challenge do
    event

    title { Faker::Lorem.word }
    description { Faker::Lorem.words(number: 10).join(' ') }
    points { 5 }
    open { true }

    trait :hidden do
      open { false }
    end

    trait :locations do
      locations { [{ 'lat': '50.0', lon: '20.0' }, { 'lat': '50.1', lon: '20.1' }] }
    end
  end
end
