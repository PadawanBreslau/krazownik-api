FactoryBot.define do
  factory :event do
    year { SelectProperYearLogic.year }
    start_time { Time.current + 3.months }
  end
end
