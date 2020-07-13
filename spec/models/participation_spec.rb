require 'rails_helper'

RSpec.describe Participation do
  it 'allows participating once' do
    user = create(:user)
    event = create(:event)
    create(:participation, user: user, event: event)

    expect(build(:participation, user: user, event: event)).not_to be_valid
  end

  context 'with results' do
    it 'creates result after save' do
      user = create(:user)
      event = create(:event)
      expect do
        create(:participation, user: user, event: event)
      end.to change(Result, :count).by(1)
    end

    it 'destroys old result after change' do
    end
  end
end
