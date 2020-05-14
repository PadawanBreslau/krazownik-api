class SendRecentRiddleService
  def call
    retrieve_current_riddle
    return unless @riddle

    send_riddle_to_all_telephones
    update_riddle_status
  end

  private

  def retrieve_current_riddle
    event = Event.find_by(year: SelectProperYearLogic.year)
    return unless event

    riddles = event.riddles&.where(sent: false)

    @riddle = riddles.find { |r| TimeDifference.between(r.visible_from, Time.current.utc).in_minutes < 15.0 }
  end

  def send_riddle_to_all_telephones
    PhoneNumber.where(send_riddles: true).each do |phone|
      MessageSendingJob.perform_later(phone: phone, content: @riddle.content)
    end
  end

  def update_riddle_status
    return false if @errors.present?

    @riddle.update(sent: true)
  end
end
