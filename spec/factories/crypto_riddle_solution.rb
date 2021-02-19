FactoryBot.define do
  factory :crypto_riddle_soultion do
    crypto_challenge
    crypto_participation

    answer { Faker::Lorem.word }
    status { false }
  end
end
