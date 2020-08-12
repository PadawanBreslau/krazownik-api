class SendInformationService
  def initialize(content:)
    @content = content
  end

  def call
    send_content
  end

  private

  def send_content
    User.where(send_messages: true).select { |u| u.phone_number }.each do |user|
      MessageSendingJob.perform_later(phone: user.phone_number, content: @content)
    end
  end
end
