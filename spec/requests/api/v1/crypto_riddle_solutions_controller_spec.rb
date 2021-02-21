require 'rails_helper'

describe Api::V1::Crypto::RiddleSolutionsController do
  describe 'create' do
    it 'sends an empty answer' do
      user = create(:user)
      participation = create(:crypto_participation)
      challenge = create(:crypto_challenge)
      post '/api/v1/crypto/riddle_solutions', headers: auth_headers(user),
                                              params: wrap_json(crypto_challenge_id: challenge.id,
                                                                crypto_participation_id: participation.id)
      expect(response).to have_http_status :unprocessable_entity
    end

    it 'sends an empty answer' do
      user = create(:user)
      participation = create(:crypto_participation)
      challenge = create(:crypto_challenge)
      post '/api/v1/crypto/riddle_solutions', headers: auth_headers(user),
                                              params: wrap_json({ crypto_challenge_id: challenge.id,
                                                        crypto_participation_id: participation.id,
                                                        answer: '' })
      expect(response).to have_http_status :unprocessable_entity
    end

    it 'sends a bad answer' do
    end
  end
end
