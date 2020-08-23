class ImageSerializer
  include FastJsonapi::ObjectSerializer

  attributes :id
  attribute :url do |object|
    Rails.application.routes.url_helpers.rails_representation_url(object.variant(resize: '600x600').processed,
                                                                  disposition: 'attachment', only_path: true)
  end

  attribute :thumb do |object|
    Rails.application.routes.url_helpers.rails_representation_url(object.variant(resize: '200x200').processed,
                                                                  disposition: 'attachment', only_path: true)
  end
end
