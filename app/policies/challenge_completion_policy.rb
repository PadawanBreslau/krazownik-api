class ChallengeCompletionPolicy < ApplicationPolicy
  def create?
    user.current_participation.event == record.challnege.event
  end
end
