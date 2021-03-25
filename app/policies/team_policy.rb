class TeamPolicy < ApplicationPolicy
  def panel?
    user.belongs_to?(record)
  end

  def photo?
    user.belongs_to?(record)
  end
end
