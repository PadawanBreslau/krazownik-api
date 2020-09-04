class ChallengeCompletionSerializer
  include FastJsonapi::ObjectSerializer
  include ImageHelper

  set_key_transform :underscore
  set_type :challenge_completion
  set_id :id

  attributes :completed, :challenge_id

  attribute :name do |object|
    object.participation.name if object.completed
  end

  attribute :avatar do |object|
    user = object.participation.user
    image_path(object: user, image_field: :avatar, resize: '120x120')
  end
end
