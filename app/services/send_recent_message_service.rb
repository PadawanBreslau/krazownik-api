class SendRecentMessageService
  def call
    retrieve_current_message
    return unless @message

    send_message_to_all_telephones
    update_message_status
  end

  private

  def retrieve_current_message
    messages = Message.where(sent: false)

    @message = messages.find { |m| TimeDifference.between(m.sent_at, Time.current.utc).in_minutes < 15.0 }
  end

  def send_message_to_all_telephones
    PhoneNumber.where(send_messages: true).each do |phone|
      MessageSendingJob.perform_later(phone: phone, content: @message.content)
    end
  end

  def update_message_status
    return false if @errors.present?

    @message.update(sent: true)
  end
end
