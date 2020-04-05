class BonusPointPresenter
  delegate_missing_to :@bonus_point

  def initialize(bonus_point, user_context:)
    @bonus_point = bonus_point
    @user_context = user_context
  end

  def completed
    @user_context&.current_participation&.bonus_point_completions&.where(completed: true)
      &.map(&:bonus_point_id)&.include?(@bonus_point.id)
  end
end
