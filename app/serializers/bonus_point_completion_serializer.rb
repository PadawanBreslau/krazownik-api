class BonusPointCompletionSerializer
  include FastJsonapi::ObjectSerializer

  set_key_transform :underscore
  set_type :bonus_point_completion
  set_id :id

  attributes :completed

  attribute :name do |object|
    object.participation.name if object.completed
  end

  attribute :bonus_point_id, &:bonus_point_id
end
