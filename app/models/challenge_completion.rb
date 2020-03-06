class ChallengeCompletion < ApplicationRecord
  belongs_to :participation
  belongs_to :challenge

  validates :challenge, uniqueness: { scope: :participation, message: 'Already checked' }

  def toggle_completion
    update(completed: !completed)
  end
end
