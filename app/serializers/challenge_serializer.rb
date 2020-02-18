class ChallengeSerializer
  include FastJsonapi::ObjectSerializer
  include Rails.application.routes.url_helpers

  set_key_transform :underscore
  set_type :challenge
  set_id :id

  has_many :challenge_conditions

  attributes :title, :description, :open, :points

  attribute :icon do |object|
    if object.icon&.attached?
      ENV['BACKEND_APP_URL'] + Rails.application.routes.url_helpers
                                    .rails_representation_url(object.icon.variant(resize: '100x100').processed,
                                                              only_path: true)
    end
  end
end
