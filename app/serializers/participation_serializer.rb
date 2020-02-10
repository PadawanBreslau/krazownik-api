class ParticipationSerializer
  include FastJsonapi::ObjectSerializer

  set_key_transform :underscore
  set_type :participation
  set_id :id

  attribute :user do |object|
    object&.user&.name
  end
end
