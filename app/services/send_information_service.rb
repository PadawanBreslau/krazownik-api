class SendInformationService
  def initialize(content:)
    @content = content
  end

  def call
    send_content
  end

  private

  def send_content
    PhoneNumber.where(send_messages: true).each do |phone|
      MessageSendingJob.perform_later(phone: phone, content: @content)
    end
  end
end
