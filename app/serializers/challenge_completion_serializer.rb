class ChallengeCompletionSerializer
  include FastJsonapi::ObjectSerializer

  set_key_transform :underscore
  set_type :challenge_completion
  set_id :id

  attributes :completed, :challenge_id
end
