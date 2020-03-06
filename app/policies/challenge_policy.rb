class ChallengePolicy < ApplicationPolicy
  def draw?
    true
  end

  def toggle?
    true
  end
end
