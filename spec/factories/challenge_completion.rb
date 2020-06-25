FactoryBot.define do
  factory :challenge_completion do
    participation
    challenge

    completed { true }
  end
end
