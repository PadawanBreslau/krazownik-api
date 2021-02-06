class PhotoSerializer
  include FastJsonapi::ObjectSerializer

  attributes :id, :creation_time
  attribute :user_name do |object|
    object.user.name
  end

  attribute :large_image do |object|
    Rails.application.routes.url_helpers.rails_representation_url(
      object.photo_image.variant(resize: '1600x1600').processed, disposition: 'attachment', only_path: true
    )
  end

  attribute :medium_image do |object|
    Rails.application.routes.url_helpers.rails_representation_url(
      object.photo_image.variant(resize: '800x800').processed, disposition: 'attachment', only_path: true
    )
  end

  attribute :small_image do |object|
    Rails.application.routes.url_helpers.rails_representation_url(
      object.photo_image.variant(resize: '300x300').processed, disposition: 'attachment', only_path: true
    )
  end

  attribute :thumb do |object|
    Rails.application.routes.url_helpers.rails_representation_url(
      object.photo_image.variant(resize: '160x160').processed, disposition: 'attachment', only_path: true
    )
  end
end
