FactoryBot.define do
  factory :event do
    year { Time.current.year + 1 }
    start_time { Time.current + 3.months }
  end
end
