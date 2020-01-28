require 'rails_helper'

describe Api::V1::BonusPointsController do
  describe 'show' do
    it 'shows bonus point' do
      bp = create(:bonus_point, name: 'Trzy Korony')
      get "/api/v1/bonus_points/#{bp.id}", headers: json_api_headers
      expect(response).to have_http_status :ok

      body = JSON.parse(response.body)['data']
      expect(body['attributes']['name']).to eq 'Trzy Korony'
    end
  end

  describe 'index' do
    it 'shows bonus_points' do
      event = create(:event, year: 2020)
      create(:bonus_point, name: 'Trzy Korony', region: 'Pieniny', event: event)
      create(:bonus_point, name: 'Turbacz', region: 'Gorce', event: event)
      get '/api/v1/bonus_points/', headers: json_api_headers
      expect(response).to have_http_status :ok

      body = JSON.parse(response.body)['data']
      expect(body.first['attributes']['name']).to eq 'Trzy Korony'
      expect(body.first['attributes']['region']).to eq 'Pieniny'
    end
  end
end
