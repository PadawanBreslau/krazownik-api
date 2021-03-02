require 'rails_helper'

describe Api::V1::Crypto::RiddleSolutionsController do
  describe 'create' do
    it 'sends without an answer' do
      user = create(:user)
      participation = create(:participation, user: user)
      participation = create(:crypto_participation, participation: participation)
      challenge = create(:crypto_challenge)
      post '/api/v1/crypto/riddle_solutions', headers: auth_headers(user),
                                              params: wrap_json(crypto_challenge_id: challenge.id,
                                                                crypto_participation_id: participation.id)
      expect(response).to have_http_status :unprocessable_entity
    end

    it 'sends an empty answer' do
      user = create(:user)
      participation = create(:participation, user: user)
      participation = create(:crypto_participation, participation: participation)
      challenge = create(:crypto_challenge)
      post '/api/v1/crypto/riddle_solutions', headers: auth_headers(user),
                                              params: wrap_json(crypto_challenge_id: challenge.id,
                                                                crypto_participation_id: participation.id,
                                                                answer: '')
      expect(response).to have_http_status :unprocessable_entity
    end

    it 'sends a bad answer' do
      user = create(:user)
      participation = create(:participation, user: user)
      participation = create(:crypto_participation, participation: participation)
      challenge = create(:crypto_challenge)
      create(:crypto_riddle, crypto_challenge: challenge, solution: 'Trzy nogi Lenina')
      expect do
        post '/api/v1/crypto/riddle_solutions', headers: auth_headers(user),
                                                params: wrap_json(crypto_challenge_id: challenge.id,
                                                                  crypto_participation_id: participation.id,
                                                                  answer: 'Znad pianina')
        expect(response).to have_http_status :ok
      end.to change(CryptoRiddleSolution, :count)
      solution = CryptoRiddleSolution.last
      expect(solution.status).to be(false)
    end

    it 'sends a good answer' do
      user = create(:user)
      participation = create(:participation, user: user)
      participation = create(:crypto_participation, participation: participation)
      challenge = create(:crypto_challenge)
      create(:crypto_riddle, crypto_challenge: challenge, solution: 'Człowiek z liściem na głowie')
      expect do
        post '/api/v1/crypto/riddle_solutions', headers: auth_headers(user),
                                                params: wrap_json(crypto_challenge_id: challenge.id,
                                                                  crypto_participation_id: participation.id,
                                                                  answer: 'czlowiek z lisciem na glowie')
        expect(response).to have_http_status :ok
      end.to change(CryptoRiddleSolution, :count)
      solution = CryptoRiddleSolution.last
      expect(solution.status).to be(true)
    end
  end
end
