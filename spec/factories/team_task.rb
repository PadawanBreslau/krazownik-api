FactoryBot.define do
  factory :team_task do
    team

    content { Faker::Lorem.sentence }
    amount { rand(1..10) }
  end
end
