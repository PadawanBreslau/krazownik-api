class CreateCryptoRiddleSolutionService
  attr_reader :status, :errors

  def initialize(params:, user:)
    @params = params
    @user = user
  end

  def call
    find_or_create_crypto_challenge
    find_or_create_crypto_participation
    save_solution

    @solution.persisted?
  end

  private

  def find_or_create_crypto_challenge
    @challenge = Event.last.crypto_challenge || CryptoChallenge.create(event: Event.last)
  end

  def find_or_create_crypto_participation
    participation = @user.participations.last
    raise 'Zapisz się na zawody' if !participation || participation.event.year != 2021

    @crypto_participation = participation.crypto_participation || CryptoParticipation.create(participation: participation)
  end

  def save_solution
    @solution = CryptoRiddleSolution.new(crypto_participation: @crypto_participation, crypto_challenge: @challenge, answer: @params['answer'])
    @solution.save

    @status = @solution.reload.status
  end
end
