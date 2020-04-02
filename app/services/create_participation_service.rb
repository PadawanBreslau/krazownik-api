class CreateParticipationService
  attr_reader :participation, :error

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
    if @event.nil?
      @error = 'Event not available yet'
      return false
    elsif already_subscribed?
      @error = 'Already subscribed to this event'
      return false
    end

    @participation = Participation.create(user: @user, event: @event)
  end

  def already_subscribed?
    Participation.find_by(user: @user, event: @event).present?
  end
end
