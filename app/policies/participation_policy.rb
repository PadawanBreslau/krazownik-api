class ParticipationPolicy < ApplicationPolicy
  def show?
    record.user == user
  end

  def create?
    true
  end
end
