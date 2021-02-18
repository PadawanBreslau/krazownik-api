class BonusPointCompletionSerializer
  include FastJsonapi::ObjectSerializer
  include ImageHelper

  set_key_transform :underscore
  set_type :bonus_point_completion
  set_id :id

  attributes :completed

  attribute :name do |object|
    object.participation.name if object.completed
  end

  attribute :avatar do |object|
    user = object.participation.user
    image_path(object: user, image_field: :avatar, resize: '120x120')
  end

  attribute :user_id do |object|
    object.participation.user.id
  end

  attribute :bonus_point_id, &:bonus_point_id
end
