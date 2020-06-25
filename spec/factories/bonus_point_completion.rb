FactoryBot.define do
  factory :bonus_point_completion do
    participation
    bonus_point

    completed { true }
  end
end
