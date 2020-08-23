require 'rails_helper'

describe Api::V1::TracksController do
  describe 'upload' do
    it 'uploads the file' do
      user = create(:user)
      params = { data: { attributes: {
        file: {}
      } } }.to_json
      post '/api/v1/tracks/upload', headers: auth_headers(user), params: params
      expect(response).to have_http_status :ok
    end
  end
end
