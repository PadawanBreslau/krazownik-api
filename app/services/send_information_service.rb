class SendInformationService
  def initialize(message:)
    @message = message
  end

  def call
    send_message
  end

  private

  def send_message
    PhoneNumber.all.each do |phone|
      MessageSendingJob.perform_later(phone: phone, message: @message)
    end
  end
end

