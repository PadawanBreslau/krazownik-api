require 'rails_helper'

describe Api::V1::ChallengesController do
  describe 'show' do
    it 'shows challanges' do
      challenge = create(:challenge)
      get "/api/v1/challenges/#{challenge.id}" #, headers: auth_headers(user)
      expect(response).to have_http_status :ok
    end
  end

  describe 'index' do

  end
end
