class ChallengeSerializer
  include FastJsonapi::ObjectSerializer

  set_key_transform :underscore
  set_type :challenge
  set_id :id

  has_many :challenge_conditions

  attributes :title, :description, :open, :points
end
