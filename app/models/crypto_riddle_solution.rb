class CryptoRiddleSolution < ApplicationRecord
  belongs_to :crypto_riddle
  belongs_to :crypto_participation

  validate :too_many_answers

  def too_many_answers
    errors.add(:answer, 'Wyczerpałeś limit prób. Spróbuj za rok :P') if crypto_participation.solutions >= 10
  end
end
