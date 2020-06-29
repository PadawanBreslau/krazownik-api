class BonusPointPolicy < ApplicationPolicy
  def toggle_completion?
    true
  end
end
