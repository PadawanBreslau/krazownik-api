class BonusPointPresenter
  delegate_missing_to :@bonus_point

  def initialize(bonus_point, completed_ids)
    @bonus_point = bonus_point
    @completed_ids = completed_ids
  end

  def completed
    return false if @completed_ids.blank?

    @completed_ids.include?(@bonus_point.id)
  end
end
