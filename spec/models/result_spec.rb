require 'rails_helper'

RSpec.describe Result do
  it 'allows result once' do
    user = create(:user)
    event = create(:event)
    participation = create(:participation, user: user, event: event)
    expect(participation.result).to be_present
    expect { create(:result, participation: participation) }.to raise_error(ActiveRecord::RecordInvalid)
  end
end
