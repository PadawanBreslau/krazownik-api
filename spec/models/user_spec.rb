require 'rails_helper'

RSpec.describe User do
  it 'validates the year' do
    expect(build(:user, birthyear: 1900)).not_to be_valid
    expect(build(:user, birthyear: 2000)).to be_valid
  end

  it 'caluclates age' do
    user = create(:user, birthyear: 1984)
    expect(user.age).to eq Date.today.year - 1984
  end
end
