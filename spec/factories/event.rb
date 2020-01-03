FactoryBot.define do
  factory :event do
    year { Time.current.year + 1 }
  end
end
