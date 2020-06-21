FactoryBot.define do
  factory :gpx_track do
    participation

    total_distance { SecureRandom.random_number * 100 }
    total_ascent { SecureRandom.random_number * 1000 }
    multiplier { 1.0 }
  end
end
