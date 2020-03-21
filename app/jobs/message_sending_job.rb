class MessageSendingJob < ApplicationJob
  def perform(phone:, content:)
    ::Mailjet::SendSms.new(phone: phone, content: content).send
  end
end
