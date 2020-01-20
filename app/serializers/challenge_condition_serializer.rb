class ChallengeConditionSerializer
  include FastJsonapi::ObjectSerializer

  set_key_transform :underscore
  set_type :challenge_condition
  set_id :id

  attributes :content
end
