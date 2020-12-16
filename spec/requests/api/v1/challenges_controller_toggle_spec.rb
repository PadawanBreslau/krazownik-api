require 'rails_helper'

describe Api::V1::ChallengesController do
  it 'toggles challenge' do
    user = create(:user)
    event = create(:event, year: SelectProperYearLogic.year)
    challenge = create(:challenge, event: event)
    create(:participation, event: event, user: user)

    expect do
      post "/api/v1/challenges/#{challenge.id}/toggle", headers: auth_headers(user)
    end.to change(ChallengeCompletion, :count).from(0).to(1)
    expect(response).to have_http_status :ok

    expect(ChallengeCompletion.last.completed).to be(true)
  end
end
