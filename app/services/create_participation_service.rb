class CreateParticipationService
  attr_reader :participation

  def initialize(user:)
    @user = user
  end

  def call
    select_current_event
    create_particiaption
  end

  private

  def select_current_event
    @event = Event.find_by(year: SelectProperYearLogic.year)
  end

  def create_particiaption
    return false unless @event

    @participation = Participation.create(user: @user, event: @event)
  end
end
