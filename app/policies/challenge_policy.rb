class ChallengePolicy < ApplicationPolicy
  def draw?
    user.present?
  end

  def toggle?
    user.current_participation.event == record.event
  end
end
