FactoryBot.define do
  factory :riddle do
    title { Faker::Lorem.word }
    content { Faker::Lorem.words(number: 10).join(' ') }
    answer { Faker::Lorem.words(number: 10).join(' ') }
    visible_from { Time.current }
  end
end
