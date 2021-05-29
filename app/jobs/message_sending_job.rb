class MessageSendingJob < ApplicationJob
  def perform(phone:, content:)
    ::Mailjet::SendSms.new(phone: phone, content: content).send if phone.present?
  end
end
