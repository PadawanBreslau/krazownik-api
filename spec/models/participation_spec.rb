require 'rails_helper'

RSpec.describe Participation do
  it 'allows participating once' do
    user = create(:user)
    event = create(:event)
    create(:participation, user: user, event: event)

    expect(build(:participation, user: user, event: event)).not_to be_valid
  end
end
