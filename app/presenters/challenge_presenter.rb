class ChallengePresenter
  delegate_missing_to :@challenge

  def initialize(challenge, user_context:)
    @challenge = challenge
    @user_context = user_context
  end

  def completed
    @user_context&.current_participation&.challenge_completions&.where(completed: true)
      &.map(&:challenge_id)&.include?(@challenge.id)
  end
end
