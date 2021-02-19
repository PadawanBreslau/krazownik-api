require 'string/similarity'

class CryptoRiddle < ApplicationRecord
  belongs_to :crypto_challenge
  has_one_attached :image
  has_many :crypto_riddle_solutions

  def accepts?(answer)
    String::Similarity.cosine(answer, solution) > 0.66
  end
end
