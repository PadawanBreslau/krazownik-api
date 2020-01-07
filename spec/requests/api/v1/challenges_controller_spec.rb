require 'rails_helper'

describe Api::V1::ChallengesController do
  describe 'show' do
    it 'shows challange' do
      challenge = create(:challenge)
      get "/api/v1/challenges/#{challenge.id}", headers: json_api_headers
      expect(response).to have_http_status :ok
    end
  end

  describe 'index' do
    it 'shows challange' do
      event = create(:event, year: Date.current.year)
      challenge = create(:challenge, title: 'W kupie sila', event: event)
      challenge2 = create(:challenge, title: 'Ten typ tak ma', event: event)
      get '/api/v1/challenges', headers: json_api_headers
      expect(response).to have_http_status :ok
    end
  end
end
