class CryptoParticipationSerializer
  include FastJsonapi::ObjectSerializer

  has_many :crypto_riddle_solutions

  attributes :id, :solutions, :good_solutions
end
