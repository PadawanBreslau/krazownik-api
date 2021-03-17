class CryptoParticipation < ApplicationRecord
  belongs_to :participation
  has_many :crypto_riddle_solutions

  def crypto_challenge
    participation.event.crypto_challenge
  end

  def solutions_size
    crypto_riddle_solutions.size
  end

  def good_solutions
    crypto_riddle_solutions.where(status: true).map(&:answer)
  end

  def bad_solutions
    crypto_riddle_solutions.where(status: false).map(&:answer)
  end
end
