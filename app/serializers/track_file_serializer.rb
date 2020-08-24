class TrackFileSerializer
  include FastJsonapi::ObjectSerializer
  include ActionView::Helpers

  attributes :metadata, :created_at, :user_id, :event_id

  attribute :filename do |object|
    object.track.blob.filename
  end

  attribute :filesize do |object|
    "#{(object.track.blob.byte_size / 1000.0).round(2)} kB"
  end

  attribute :username do |object|
    object.user.name
  end

  attribute :year do |object|
    object.event.year
  end
end
