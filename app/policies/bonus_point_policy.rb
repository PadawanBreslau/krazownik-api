class BonusPointPolicy < ApplicationPolicy
  def toggle_completion?
    true
  end

  def toggle?
    true
  end
end
