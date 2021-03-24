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

    it 'show team tasks' do
      participation = create(:participation)
      team = create(:team, name: 'Arsenal')
      task = create(:team_task, team: team)

      team.participations << participation
      get "/api/v1/teams/#{team.id}", headers: json_api_headers
      expect(response).to have_http_status :ok

      body = JSON.parse(response.body)['data']
      included = JSON.parse(response.body)['included']
      expect(body.dig('relationships', 'team_tasks')).to be_present
      expect(included.last['type']).to eq 'team_tasks'
      expect(included.last['id']).to eq task.id.to_s
    end

    it 'shows that this is your own team' do
      user = create(:user)
      participation = create(:participation, user: user)
      team = create(:team, name: 'Blackpool')

      team.participations << participation
      get "/api/v1/teams/#{team.id}", headers: auth_headers(user)
      expect(response).to have_http_status :ok

      body = JSON.parse(response.body)['data']
      expect(body['attributes']['own']).to eq(true)
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
