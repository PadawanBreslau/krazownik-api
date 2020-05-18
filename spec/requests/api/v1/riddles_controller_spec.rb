require 'rails_helper'

describe Api::V1::RiddlesController do
  describe 'show' do
    it 'shows challange' do
      riddle = create(:riddle, title: 'Ile lat ma Grześ?', sponsor: 'Microsoft')
      get "/api/v1/riddles/#{riddle.id}", headers: json_api_headers
      expect(response).to have_http_status :ok

      body = JSON.parse(response.body)['data']
      expect(body['attributes']['title']).to eq 'Ile lat ma Grześ?'
      expect(body['attributes']['content']).to be_present
      expect(body['attributes']['answer']).to be_nil
      expect(body['attributes']['sponsor']).to eq 'Microsoft'
    end

    it 'doesnt show question when the time is not reached' do
      riddle = create(:riddle, title: 'Ile lat ma Kuba?', visible_from: Time.current + 3.hours)
      get "/api/v1/riddles/#{riddle.id}", headers: json_api_headers
      expect(response).to have_http_status :ok

      body = JSON.parse(response.body)['data']
      expect(body['attributes']['title']).to eq 'Ile lat ma Kuba?'
      expect(body['attributes']['content']).to be_nil
      expect(body['attributes']['answer']).to be_nil
    end

    it 'show answer when the time is due' do
      riddle = create(:riddle, title: 'Ile jest 2+2?', visible_from: Time.current - 3.hours)
      get "/api/v1/riddles/#{riddle.id}", headers: json_api_headers
      expect(response).to have_http_status :ok

      body = JSON.parse(response.body)['data']
      expect(body['attributes']['title']).to eq 'Ile jest 2+2?'
      expect(body['attributes']['content']).to be_present
      expect(body['attributes']['answer']).to be_present
    end
  end

  describe 'index' do
    it 'shows riddles' do
      create(:riddle, title: 'W którą stronę?', visible_from: Time.current)
      create(:riddle, title: 'Jaki jest wynik?', visible_from: Time.current - 2.hours)
      get '/api/v1/riddles', headers: json_api_headers
      expect(response).to have_http_status :ok

      body = JSON.parse(response.body)['data']
      expect(body.last['attributes']['title']).to eq 'W którą stronę?'
      expect(body.first['attributes']['title']).to eq 'Jaki jest wynik?'
    end
  end
end
