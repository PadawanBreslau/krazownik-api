class CryptoChallenge < ApplicationRecord
  belongs_to :event
  has_many :crypto_riddles
  has_many :crypto_riddle_solutions
end
