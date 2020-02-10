require 'rails_helper'

describe Api::V1::TeamsController do
  describe 'show' do
    it 'shows team' do
      participation = create(:participation)
      team = create(:team, name: 'Arsenal')

      team.participations << participation
      get "/api/v1/teams/#{team.id}", headers: json_api_headers
      expect(response).to have_http_status :ok

      body = JSON.parse(response.body)['data']
      expect(body['attributes']['name']).to eq 'Arsenal'
    end
  end

  describe 'index' do
    it 'shows teams' do
      participation = create(:participation)
      team = create(:team, name: 'Chelsea')
      team.participations << participation

      get '/api/v1/teams/', headers: json_api_headers
      expect(response).to have_http_status :ok

      body = JSON.parse(response.body)['data']
      expect(body.first['attributes']['name']).to eq 'Chelsea'
    end
  end
end
