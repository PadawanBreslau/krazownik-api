require 'rails_helper'

describe Api::V1::PhotosController do
  describe 'show' do
    it 'shows photo' do
      user = create(:user)
      photo = create(:photo, user: user)

      get "/api/v1/photos/#{photo.id}", headers: json_api_headers
      expect(response).to have_http_status :ok

      body = JSON.parse(response.body)['data']
      expect(body.dig('attributes', 'large_image')).to be_present
    end
  end

  describe 'index' do
    it 'shows photos' do
      user = create(:user)
      create(:photo, user: user)
      create(:photo, user: user)

      get '/api/v1/photos', headers: json_api_headers
      expect(response).to have_http_status :ok

      body = JSON.parse(response.body)['data']
      expect(body.size).to eq 2
      expect(body.first.dig('attributes', 'url')).to be_present
      expect(body.first.dig('attributes', 'thumb')).to be_present
    end
  end
end
