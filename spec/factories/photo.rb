FactoryBot.define do
  factory :photo do
    user
    event
    creation_time { Time.current - 2.days }
    photo_image { Rack::Test::UploadedFile.new('spec/factories/image.png', 'image/png') }
  end
end
