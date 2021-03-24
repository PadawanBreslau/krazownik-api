require 'string/similarity'

class CryptoRiddle < ApplicationRecord
  belongs_to :crypto_challenge
  has_one_attached :image
  has_many :crypto_riddle_solutions

  scope :current, -> { joins(:crypto_challenge).where('crypto_challenges.event_id = ?', Event.last.id) }

  def accepts?(answer)
    String::Similarity.cosine(answer, solution) > 0.72
  end
end
