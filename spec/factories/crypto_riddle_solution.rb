FactoryBot.define do
  factory :crypto_riddle_solution do
    crypto_challenge
    crypto_participation

    status { false }
  end
end
