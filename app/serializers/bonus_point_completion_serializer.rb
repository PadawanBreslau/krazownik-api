class BonusPointCompletionSerializer
  include FastJsonapi::ObjectSerializer

  set_key_transform :underscore
  set_type :bonus_point_completion
  set_id :id

  attributes :completed

  attribute :name do |object|
    object.participation.name if object.completed
  end

  belongs_to :participation
  belongs_to :bonus_point
end
