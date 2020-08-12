require 'rails_helper'

RSpec.describe SendInformationService do
  it 'sends message to phone that agreed' do
    user = create(:user, :with_phone)
    service = described_class.new(content: 'This is message for you')

    expect do
      service.call
    end.to have_enqueued_job(MessageSendingJob)
  end

  it 'doesnt send message if didnt agree' do
    create(:user, :with_phone, send_messages: false)
    service = described_class.new(content: 'This is message for you')

    expect do
      service.call
    end.not_to have_enqueued_job(MessageSendingJob)
  end
end
