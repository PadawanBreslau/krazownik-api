class ChallengeSerializer
  include FastJsonapi::ObjectSerializer

  set_key_transform :underscore
  set_type :challenge
  set_id :id

  attributes :title, :description, :open, :points
end
