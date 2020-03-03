require 'rails_helper'

describe Api::V1::ParticipationsController do
  describe 'show' do
    it 'shows participation' do
      user = create(:user)
      event = create(:event)
      participation = create(:participation, user: user)
      get "/api/v1/participations/#{participation.id}", headers: auth_headers(user)
      expect(response).to have_http_status :ok

      body = JSON.parse(response.body)['data']
      expect(body['attributes']['year']).to eq event.year
    end
  end

  describe 'index' do
    it 'shows participation' do
      user = create(:user)
      event = create(:event, year: Date.current.year)
      old_event = create(:event, year: Date.current.year - 1)
      create(:participation, event: event, user: user)
      create(:participation, event: old_event, user: user)
      get '/api/v1/participations', headers: auth_headers(user)
      expect(response).to have_http_status :ok

      body = JSON.parse(response.body)['data']
      expect(body.first['attributes']['year']).to eq event.year
      expect(body.last['attributes']['year']).to eq old_event.year
    end
  end

  describe 'create' do
    it 'creates a participation' do
      user = create(:user)
      event = create(:event, year: SelectProperYearLogic.year)
      post '/api/v1/participations', headers: auth_headers(user)
      expect(response).to have_http_status :ok

      expect(Participation.last.event).to eq event
    end
  end
end
