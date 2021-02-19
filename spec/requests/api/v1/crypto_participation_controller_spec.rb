require 'rails_helper'

describe Api::V1::Crypto::ParticipationsController do
  describe 'show' do
    it 'shows empty particpations' do
      crypto_participation = create(:crypto_participation)
      get "/api/v1/crypto/participations/#{crypto_participation.id}", headers: json_api_headers
      expect(response).to have_http_status :ok

      body = JSON.parse(response.body)['data']
      expect(body['attributes']['good_solutions']).to be_empty
      expect(body['attributes']['bad_solutions']).to be_empty
      expect(body['attributes']['solutions_size']).to eq 0
    end

    it 'shows good answers' do
      event = create(:event)
      participation = create(:participation, event: event)
      crypto_participation = create(:crypto_participation, participation: participation)
      crypto_challenge = create(:crypto_challenge, event: event)
      create(:crypto_riddle, crypto_challenge: crypto_challenge, solution: 'test')
      create(:crypto_riddle_solution, crypto_participation: crypto_participation,
                                      crypto_challenge: crypto_challenge, answer: 'test')
      get "/api/v1/crypto/participations/#{crypto_participation.id}", headers: json_api_headers
      body = JSON.parse(response.body)['data']
      expect(body['attributes']['good_solutions']).to eq ['test']
      expect(body['attributes']['bad_solutions']).to be_empty
      expect(body['attributes']['solutions_size']).to eq 1
    end

    it 'shows similar answers' do
      event = create(:event)
      participation = create(:participation, event: event)
      crypto_participation = create(:crypto_participation, participation: participation)
      crypto_challenge = create(:crypto_challenge, event: event)
      create(:crypto_riddle, crypto_challenge: crypto_challenge, solution: 'test')
      create(:crypto_riddle_solution, crypto_participation: crypto_participation,
                                      crypto_challenge: crypto_challenge, answer: 'Testy')
      get "/api/v1/crypto/participations/#{crypto_participation.id}", headers: json_api_headers
      body = JSON.parse(response.body)['data']
      expect(body['attributes']['good_solutions']).to eq ['Testy']
      expect(body['attributes']['bad_solutions']).to be_empty
      expect(body['attributes']['solutions_size']).to eq 1
    end

    it 'allows only one answer per riddle' do
      event = create(:event)
      participation = create(:participation, event: event)
      crypto_participation = create(:crypto_participation, participation: participation)
      crypto_challenge = create(:crypto_challenge, event: event)
      create(:crypto_riddle, crypto_challenge: crypto_challenge, solution: 'test')
      create(:crypto_riddle_solution, crypto_participation: crypto_participation,
                                      crypto_challenge: crypto_challenge, answer: 'test')
      create(:crypto_riddle_solution, crypto_participation: crypto_participation,
                                      crypto_challenge: crypto_challenge, answer: 'test')
      get "/api/v1/crypto/participations/#{crypto_participation.id}", headers: json_api_headers
      body = JSON.parse(response.body)['data']
      expect(body['attributes']['good_solutions']).to eq ['test']
      expect(body['attributes']['bad_solutions']).to eq ['test']
      expect(body['attributes']['solutions_size']).to eq 2
    end
  end
end
