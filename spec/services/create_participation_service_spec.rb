require 'rails_helper'

RSpec.describe CreateParticipationService do
  it 'creates participation' do
    user = create(:user)
    event = create(:event, year: SelectProperYearLogic.year)

    expect  do
      described_class.new(user: user).call
    end.to change(Participation, :count)

    expect(Participation.last.event).to eq event
  end

  it 'returns error when no event' do
    user = create(:user)
    service = described_class.new(user: user)

    expect  do
      service.call
    end.not_to change(Participation, :count)
    expect(service.error).to eq 'Event not available yet'
  end

  it 'return error when already participating' do
    user = create(:user)
    event = create(:event, year: SelectProperYearLogic.year)
    create(:participation, event: event, user: user)
    service = described_class.new(user: user)

    expect  do
      service.call
    end.not_to change(Participation, :count)
    expect(service.error).to eq 'Already subscribed to this event'
  end
end
