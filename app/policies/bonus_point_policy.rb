class BonusPointPolicy < ApplicationPolicy
  def show?
    true
  end

  def index?
    true
  end

  def toggle?
    user.current_participation.event == record.event
  end
end
