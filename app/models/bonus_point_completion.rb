class BonusPointCompletion < ApplicationRecord
  belongs_to :bonus_point
  belongs_to :participation

  def toggle
    update(:completed, !completed)
  end
end
