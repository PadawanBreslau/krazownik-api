
require 'rails_helper'

RSpec.describe SendRecentRiddleService do
  it 'sends riddles for those who agree' do
    create(:phone_number, send_riddles: false)
    event = create(:event, year: SelectProperYearLogic.year)
    create(:riddle, visible_from: Time.current, event: event)

    expect do
      described_class.new.call
    end.to have_enqueued_job(MessageSendingJob)
  end

  it 'doesnt send riddles for those who dont agree' do
    create(:phone_number, send_riddles: false)
    event = create(:event, year: SelectProperYearLogic.year)
    create(:riddle, visible_from: Time.current, event: event)

    expect do
      described_class.new.call
    end.not_to have_enqueued_job(MessageSendingJob)
  end
end
