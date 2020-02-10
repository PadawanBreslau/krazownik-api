FactoryBot.define do
  factory :team do
    name { Faker::Name.name }
    event
  end
end
