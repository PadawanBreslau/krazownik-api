require 'rails_helper'

describe Api::V1::Crypto::ParticipationsController do
  describe 'show' do
    it 'shows empty particpations' do
      crypto_participation = create(:crypto_participation)
      get "/api/v1/crypto/participations/#{crypto_participation.id}", headers: json_api_headers
      expect(response).to have_http_status :ok

      body = JSON.parse(response.body)['data']
    end
  end
end
