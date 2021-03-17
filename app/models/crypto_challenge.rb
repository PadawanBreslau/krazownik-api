class CryptoChallenge < ApplicationRecord
  belongs_to :event
  has_many :crypto_riddles
  has_many :crypto_riddle_solutions

  def crypto_participations
    Participation.where(event: event).map(&:crypto_participation).compact
  end

  def finished?
    winner.present?
  end

  def set_winner!
    update(winner_participation_id: winner.first.participation_id)
  end

  private

  def winner
    crypto_participations.select { |p| p.good_solutions.size == crypto_riddles.size }
  end
end
