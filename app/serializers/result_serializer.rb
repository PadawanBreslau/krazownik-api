class ResultSerializer
  include FastJsonapi::ObjectSerializer

  set_key_transform :underscore
  set_type :result
  set_id :id

  has_one :participation
  attributes :result, :total

  attribute :name do |object|
    object.participation.user.name
  end
end
