class CryptoRiddleSolution < ApplicationRecord
  belongs_to :crypto_challenge
  belongs_to :crypto_participation, counter_cache: true

  validate :too_many_answers
  validates :answer, presence: true
  after_create :check_answer

  def too_many_answers
    errors.add(:answer, 'Wyczerpałeś limit prób. Spróbuj za rok :P') if crypto_participation.solutions_size >= 10
  end

  def check_answer
    if find_riddle_with_that_answer
      update(status: true)
      update(good_answer_id: @riddle.id)
    end
  end

  def find_riddle_with_that_answer
    crypto_participation.reload
    taken_ids = crypto_participation.crypto_riddle_solutions.pluck(:good_answer_id).compact
    @riddle = crypto_challenge.crypto_riddles.where.not(id: taken_ids).find { |r| r.accepts?(answer) }
    @riddle.present?
  end
end
