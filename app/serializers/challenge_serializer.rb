class ChallengeSerializer
  include FastJsonapi::ObjectSerializer
  include ImageHelper

  set_key_transform :underscore
  set_type :challenge
  set_id :id

  has_many :challenge_conditions
  has_many :challenge_completions

  attributes :title, :description, :open, :points, :completed, :locations

  attribute :completed do |object, params|
    params[:user] ? object.completed?(params[:user]) : false
  end

  attribute :icon do |object|
    image_path(object: object, image_field: :icon)
  end
end
