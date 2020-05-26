class PhotoSerializer
  include FastJsonapi::ObjectSerializer

  attributes :id

  attribute :participation_id, &:record_id

  attribute :url do |object|
    Rails.application.routes.url_helpers.rails_representation_url(object.variant(resize: '800x800').processed,
                                                                  disposition: 'attachment', only_path: true)
  end
end
