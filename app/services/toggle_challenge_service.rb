class ToggleChallengeService
  attr_reader :challenge_completion, :error

  def initialize(user:, challenge_id:)
    @user = user
    @challenge_id = challenge_id
  end

  def call
    find_current_participation

    return false unless @participation

    find_or_create_challenge_completion
  end

  private

  def find_current_participation
    @participation = @user.current_participation
  end

  def find_or_create_challenge_completion
    @challenge_completion = ChallengeCompletion.find_by(participation_id: @participation.id,
                                                        challenge_id: @challenge_id)

    if @challenge_completion.present?
      @challenge_completion.toggle_completion
    else
      @challenge_completion = ChallengeCompletion.create(participation_id: @participation.id,
                                                         challenge_id: @challenge_id, completed: true)
    end
  end
end
