require 'rails_helper'

RSpec.describe BonusPointCompletion do
  it 'toggles completion' do
    bc = create(:bonus_point_completion)
    expect(bc.completed).to be(true)
    bc.toggle_completion
    expect(bc.completed).to be(false)
    bc.toggle_completion
    expect(bc.completed).to be(true)
  end
end
