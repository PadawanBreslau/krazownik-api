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

    it 'return locations' do
      challenge = create(:challenge, :locations, title: 'Spisz?')
      expect(challenge.locations.size).to eq 2
      expect(challenge.locations.first.keys).to eq %w(lat lon)
    end
  end

  describe 'index' do
    it 'shows challange' do
      event = create(:event, year: SelectProperYearLogic.year)
      create(:challenge, title: 'W kupie siła', event: event)
      create(:challenge, title: 'Ten typ tak ma', event: event)
      get '/api/v1/challenges', headers: json_api_headers
      expect(response).to have_http_status :ok

      body = JSON.parse(response.body)['data']
      expect(body.first['attributes']['title']).to eq 'W kupie siła'
      expect(body.last['attributes']['title']).to eq 'Ten typ tak ma'
    end
  end

  describe 'draw' do
    it 'draws a challenge' do
      user = create(:user)
      event = create(:event, year: SelectProperYearLogic.year)
      create(:participation, event: event, user: user)
      create(:challenge, :hidden,  title: 'W kupie siła', event: event, points: 12)
      create(:challenge, :hidden,  title: 'Ten typ tak ma', event: event, points: 8)

      params = { data: { attributes: {
        max_points: 8
      } } }.to_json

      post '/api/v1/challenges/draw', headers: auth_headers(user), params: params
      expect(response).to have_http_status :ok

      body = JSON.parse(response.body)['data']
      expect(body['attributes']['title']).to eq 'Ten typ tak ma'
    end

    it 'doesnt redraw challenge' do
      user = create(:user)
      event = create(:event, year: SelectProperYearLogic.year)
      create(:participation, event: event, user: user)
      create(:challenge, :hidden, title: 'W kupie siła', event: event, points: 12)

      params = { data: { attributes: {
        max_points: 12
      } } }.to_json

      post '/api/v1/challenges/draw', headers: auth_headers(user), params: params
      expect(response).to have_http_status :ok

      post '/api/v1/challenges/draw', headers: auth_headers(user), params: params
      expect(response).to have_http_status :unprocessable_entity
    end

    it 'wont draw challenge with more points' do
      user = create(:user)
      event = create(:event, year: SelectProperYearLogic.year)
      create(:participation, event: event, user: user)
      create(:challenge, :hidden, title: 'W kupie siła', event: event, points: 12)

      params = { data: { attributes: {
        max_points: 5
      } } }.to_json

      post '/api/v1/challenges/draw', headers: auth_headers(user), params: params
      expect(response).to have_http_status :unprocessable_entity
    end

    it 'create challenge completion' do
      user = create(:user)
      event = create(:event, year: SelectProperYearLogic.year)
      create(:participation, event: event, user: user)
      create(:challenge, :hidden,  title: 'W kupie siła', event: event, points: 12)
      create(:challenge, :hidden,  title: 'Ten typ tak ma', event: event, points: 8)

      params = { data: { attributes: {
        max_points: 8
      } } }.to_json

      expect do
        post '/api/v1/challenges/draw', headers: auth_headers(user), params: params
      end.to change(ChallengeCompletion, :count).by(1)

      expect(response).to have_http_status :ok
    end
  end
end
