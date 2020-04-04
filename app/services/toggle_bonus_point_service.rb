class ToggleBonusPointService
  attr_reader :bonus_point, :error

  def initialize(user:, bonus_point_id:)
    @user = user
    @bonus_point_id = bonus_point_id
  end

  def call
    find_bonus_point_and_participation
    toggle_bonus_point_completion
  end

  private

  def find_bonus_point_and_participation
    @bonus_point = BonusPoint.find(@bonus_point_id)
    @participation = @user.current_participation
  end

  def toggle_bonus_point_completion
    bonus_point_completion = BonusPointCompletion.find_or_create_by(participation_id: @participation.id,
                                                                    bonus_point_id: @bonus_point.id)
    bonus_point_completion.toggle
  end
end
