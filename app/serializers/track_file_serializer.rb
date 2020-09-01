class TrackFileSerializer
  include FastJsonapi::ObjectSerializer
  include ActionView::Helpers

  has_many :gpx_points

  attributes :multiplier, :metadata, :created_at, :user_id, :event_id, :year, :custom_name

  attribute :filename, &:filename

  attribute :filesize do |object|
    "#{(object.byte_size / 1000.0).round(2)} kB"
  end

  attribute :username do |object|
    object.user.name
  end
end
