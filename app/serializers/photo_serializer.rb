class PhotoSerializer
  include FastJsonapi::ObjectSerializer

  attributes :id, :creation_time
  attribute :user_name do |object|
    object.user.name
  end

  attribute :photo_image do |object|
    Rails.application.routes.url_helpers.rails_representation_url(
      object.photo_image.variant(resize: '600x600').processed, disposition: 'attachment', only_path: true
    )
  end
end
