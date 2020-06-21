class ResultCalculator
  attr_reader :result, :total

  def initialize(participation:)
    @participation = participation
  end

  def call
    @result = Hash.new(0)
    points_from_routes
    points_from_places
    points_from_challenges
    points_from_extra

    @total = @result.values.compact.inject(:+)
  end

  private

  def points_from_routes
    @result['points_from_km'] = @participation.total_distance_points
    @result['points_from_ascent'] = @participation.total_ascent_points
  end

  def points_from_places
    @result['points_from_bonus_points'] = @participation.bonus_point_completions.where(completed: true)
      &.map { |bpc| bpc.bonus_point.points }&.inject(:+)
  end

  def points_from_challenges
    @result['points_from_challenges'] = @participation.challenge_completions.where(completed: true)
      &.map { |chc| chc.challenge.points }&.inject(:+)
  end

  def points_from_extra
    @result['extra_points'] = @participation.extra&.points
  end
end
