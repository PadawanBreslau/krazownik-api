class BonusPointCompletion < ApplicationRecord
  belongs_to :bonus_point
  belongs_to :participation, autosave: true

  def toggle_completion
    update(completed: !completed)
  end
end
