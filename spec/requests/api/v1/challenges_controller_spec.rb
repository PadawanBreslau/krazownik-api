require 'rails_helper'

describe Api::V1::ChallengesController do
  describe 'show' do
    it 'shows challange' do
      challenge = create(:challenge, title: 'Spisz?')
      get "/api/v1/challenges/#{challenge.id}", headers: json_api_headers
      expect(response).to have_http_status :ok

      body = JSON.parse(response.body)['data']
      expect(body['attributes']['title']).to eq 'Spisz?'
    end
  end

  describe 'index' do
    it 'shows challange' do
      event = create(:event, year: Date.current.year)
      create(:challenge, title: 'W kupie siła', event: event)
      create(:challenge, title: 'Ten typ tak ma', event: event)
      get '/api/v1/challenges', headers: json_api_headers
      expect(response).to have_http_status :ok

      body = JSON.parse(response.body)['data']
      expect(body.first['attributes']['title']).to eq 'W kupie siła'
      expect(body.last['attributes']['title']).to eq 'Ten typ tak ma'
    end
  end
end
