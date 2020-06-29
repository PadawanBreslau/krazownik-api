class ChallengePolicy < ApplicationPolicy
  def draw?
    true
  end

  def toggle_completion?
    true
  end
end
