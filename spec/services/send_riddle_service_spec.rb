require 'rails_helper'

RSpec.describe SendRecentRiddleService do
  it 'sends riddles for those who agree' do
    create(:phone_number, send_riddles: true)
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

  it 'select riddle if time is close enough' do
    create(:phone_number, send_riddles: true)
    event = create(:event, year: SelectProperYearLogic.year)
    create(:riddle, visible_from: Time.current + 5.minutes, event: event)

    expect do
      described_class.new.call
    end.to have_enqueued_job(MessageSendingJob)
  end

  it 'select riddle if time is close enough - earlier' do
    create(:phone_number, send_riddles: true)
    event = create(:event, year: SelectProperYearLogic.year)
    create(:riddle, visible_from: Time.current - 5.minutes, event: event)

    expect do
      described_class.new.call
    end.to have_enqueued_job(MessageSendingJob)
  end

  it 'send riddle only once' do
    create(:phone_number, send_riddles: true)
    event = create(:event, year: SelectProperYearLogic.year)
    riddle = create(:riddle, visible_from: Time.current, event: event)

    expect do
      described_class.new.call
    end.to have_enqueued_job(MessageSendingJob)

    expect(riddle.reload.sent).to be(true)

    expect do
      described_class.new.call
    end.not_to have_enqueued_job(MessageSendingJob)
  end
end
