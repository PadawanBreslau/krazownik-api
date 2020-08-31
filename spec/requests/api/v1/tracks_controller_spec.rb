require 'rails_helper'

describe Api::V1::TracksController do
  describe 'show' do
    it 'shows file' do
      user = create(:user)
      event = create(:event)

      track = create(:track_file, user: user, event: event)
      FactoryBot.rewind_sequences
      get "/api/v1/tracks/#{track.id}", headers: auth_headers(user)
      expect(response).to have_http_status :ok

      body = JSON.parse(response.body)['data']['attributes']
      expect(body['filename']).to eq 'track1.gpx'
      expect(body['filesize']).to eq '18.67 kB'
      expect(body['event_id']).to eq event.id
      expect(body['user_id']).to eq user.id
      expect(body['username']).to eq user.name
      expect(body['year']).to eq event.year
    end
  end

  describe 'index' do
    it 'shows files' do
      user = create(:user)
      event = create(:event)

      track = create(:track_file, user: user, event: event)
      track2 = create(:track_file, user: user, event: event)
      track3 = create(:track_file, user: user, event: event)
      FactoryBot.rewind_sequences
      get '/api/v1/tracks/', headers: auth_headers(user)
      expect(response).to have_http_status :ok

      body_data = JSON.parse(response.body)['data']
      expect(body_data.size).to eq 3
      expect(body_data.map { |bd| bd['attributes']['filename'] }
        .difference([track.filename, track2.filename, track3.filename])).to be_empty
    end
  end

  describe 'upload' do
    it 'uploads the file' do
      user = create(:user)
      event = create(:event)
      create(:participation, user: user, event: event)
      params = { data: { attributes: {
        file: {
          "filename": 'test.gpx',
          "content_type": 'application/gpx+xml',
          "data": File.read('spec/factories/tracks/b64/file.b64')
        }
      } } }.to_json
      post '/api/v1/tracks/upload', headers: auth_headers(user), params: params
      expect(response).to have_http_status :ok
    end

    it 'dissalows adding same file' do
      user = create(:user)
      event = create(:event)
      create(:participation, user: user, event: event)
      params = { data: { attributes: {
        file: {
          "filename": 'test.gpx',
          "content_type": 'application/gpx+xml',
          "data": File.read('spec/factories/tracks/b64/file.b64')
        }
      } } }.to_json
      post '/api/v1/tracks/upload', headers: auth_headers(user), params: params
      expect(response).to have_http_status :ok

      post '/api/v1/tracks/upload', headers: auth_headers(user), params: params
      expect(response).to have_http_status :unprocessable_entity
    end
  end
end
