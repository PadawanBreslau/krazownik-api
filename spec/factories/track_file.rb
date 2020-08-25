FactoryBot.define do
  factory :track_file do
    user
    event
    metadata { {} }
    sequence(:track) do |n|
      Rack::Test::UploadedFile.new("spec/factories/tracks/track#{n}.gpx", 'xml/gpx')
    end
  end
end
