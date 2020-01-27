class TeamSerializer
  include FastJsonapi::ObjectSerializer

  set_key_transform :underscore
  set_type :teams
  set_id :id

  attribute :name

  has_many :users
end
