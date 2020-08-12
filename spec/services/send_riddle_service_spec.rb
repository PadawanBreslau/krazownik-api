require 'rails_helper'

RSpec.describe SendRecentRiddleService do
  it 'sends riddles for those who agree' do
    user = create(:user, :with_phone)
    event = create(:event, year: SelectProperYearLogic.year)
    create(:riddle, visible_from: Time.current, event: event)
    create(:participation, event: event, user: user)

    expect do
      described_class.new.call
    end.to have_enqueued_job(MessageSendingJob)
  end

  it 'doesnt send riddles for those who dont agree' do
    user = create(:user, :with_phone, send_riddles: false)
    event = create(:event, year: SelectProperYearLogic.year)
    create(:riddle, visible_from: Time.current, event: event)
    create(:participation, event: event, user: user)

    expect do
      described_class.new.call
    end.not_to have_enqueued_job(MessageSendingJob)
  end

  it 'select riddle if time is close enough' do
    user = create(:user, :with_phone)
    event = create(:event, year: SelectProperYearLogic.year)
    create(:riddle, visible_from: Time.current + 5.minutes, event: event)
    create(:participation, event: event, user: user)

    expect do
      described_class.new.call
    end.to have_enqueued_job(MessageSendingJob)
  end

  it 'select riddle if time is close enough - earlier' do
    user = create(:user, :with_phone)
    event = create(:event, year: SelectProperYearLogic.year)
    create(:riddle, visible_from: Time.current - 5.minutes, event: event)
    create(:participation, event: event, user: user)

    expect do
      described_class.new.call
    end.to have_enqueued_job(MessageSendingJob)
  end

  it 'send riddle only once' do
    user = create(:user, :with_phone)
    event = create(:event, year: SelectProperYearLogic.year)
    riddle = create(:riddle, visible_from: Time.current, event: event)
    create(:participation, event: event, user: user)

    expect do
      described_class.new.call
    end.to have_enqueued_job(MessageSendingJob)

    expect(riddle.reload.sent).to be(true)

    expect do
      described_class.new.call
    end.not_to have_enqueued_job(MessageSendingJob)
  end
end
