FactoryBot.define do
  factory :track_file do
    user
    event
    metadata { {} }
    track { Rack::Test::UploadedFile.new('spec/factories/track.gpx', 'xml/gpx') }
  end
end
