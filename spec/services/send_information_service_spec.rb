
require 'rails_helper'

RSpec.describe SendInformationService do
  it 'sends message to phone that agreed' do
    create(:phone_number, send_messages: true)
    service = described_class.new(content: 'This is message for you')

    expect do
      service.call
    end.to have_enqueued_job(MessageSendingJob)
  end

  it 'doesnt send message if didnt agree' do
    create(:phone_number, send_messages: false)
    service = described_class.new(content: 'This is message for you')

    expect do
      service.call
    end.not_to have_enqueued_job(MessageSendingJob)
  end
end
