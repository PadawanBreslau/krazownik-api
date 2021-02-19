class CryptoParticipation < ApplicationRecord
  belongs_to :participation
  has_many :crypto_riddle_solutions

  def solutions
    crypto_riddle_solutions.size
  end

  def good_solutions
    crypto_riddle_solutions.where(status: true)
  end
end
