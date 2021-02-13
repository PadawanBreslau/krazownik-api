class DrawChallengeService
  attr_reader :challenge, :error

  def initialize(params:, user:)
    @params = params
    @user = user
  end

  def call
    extract_crucial_data

    return false if @error.present?
    return false if @current_challenges.size >= 3 || @possible_challenges.size.zero?

    randomize_challenge
  end

  private

  def extract_crucial_data
    max_points = (@params[:max_points] || 3).to_i

    @participation = @user.current_participation
    (@error = 'No participation found') && return unless @participation

    @current_challenges = @participation.challenge_completions&.map(&:challenge)

    @possible_challenges = Challenge.current(SelectProperYearLogic.year)
                                    .hidden.where.not(id: @current_challenges.map(&:id))
                                    .includes([icon_attachment: :blob])
                                    .select { |c| c.points == max_points }
  end

  def randomize_challenge
    @challenge = @possible_challenges.sample
    ChallengeCompletion.create(challenge: @challenge, participation: @participation, completed: false)
  end
end
