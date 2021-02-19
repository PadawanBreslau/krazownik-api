class CryptoParticipationSerializer
  include FastJsonapi::ObjectSerializer

  has_many :crypto_riddle_solutions

  attributes :id, :solutions_size, :good_solutions, :bad_solutions
end
