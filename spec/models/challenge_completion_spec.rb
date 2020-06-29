require 'rails_helper'

RSpec.describe ChallengeCompletion do
  it 'toggles completion' do
    cc = create(:challenge_completion)
    expect(cc.completed).to be(true)
    cc.toggle_completion
    expect(cc.completed).to be(false)
    cc.toggle_completion
    expect(cc.completed).to be(true)
  end
end
