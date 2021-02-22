require 'rails_helper'

describe Api::V1::Crypto::ParticipationsController do
  describe 'show' do
    it 'shows empty particpations' do
      user = create(:user)
      crypto_participation = create(:crypto_participation)
      get "/api/v1/crypto/participations/#{crypto_participation.id}", headers: auth_headers(user)
      expect(response).to have_http_status :ok

      body = JSON.parse(response.body)['data']
      expect(body['attributes']['good_solutions']).to be_empty
      expect(body['attributes']['bad_solutions']).to be_empty
      expect(body['attributes']['good_solutions_size']).to eq 0
      expect(body['attributes']['bad_solutions_size']).to eq 0
      expect(body['attributes']['solutions_size']).to eq 0
    end

    it 'shows good answers' do
      user = create(:user)
      event = create(:event)
      participation = create(:participation, event: event)
      crypto_participation = create(:crypto_participation, participation: participation)
      crypto_challenge = create(:crypto_challenge, event: event)
      create(:crypto_riddle, crypto_challenge: crypto_challenge, solution: 'test')
      create(:crypto_riddle_solution, crypto_participation: crypto_participation,
                                      crypto_challenge: crypto_challenge, answer: 'test')
      get "/api/v1/crypto/participations/#{crypto_participation.id}", headers: auth_headers(user)
      body = JSON.parse(response.body)['data']
      expect(body['attributes']['good_solutions']).to eq ['test']
      expect(body['attributes']['bad_solutions']).to be_empty
      expect(body['attributes']['good_solutions_size']).to eq 1
      expect(body['attributes']['bad_solutions_size']).to eq 0
      expect(body['attributes']['solutions_size']).to eq 1
    end

    it 'shows similar answers' do
      user = create(:user)
      event = create(:event)
      participation = create(:participation, event: event)
      crypto_participation = create(:crypto_participation, participation: participation)
      crypto_challenge = create(:crypto_challenge, event: event)
      create(:crypto_riddle, crypto_challenge: crypto_challenge, solution: 'test')
      create(:crypto_riddle_solution, crypto_participation: crypto_participation,
                                      crypto_challenge: crypto_challenge, answer: 'Testy')
      get "/api/v1/crypto/participations/#{crypto_participation.id}", headers: auth_headers(user)
      body = JSON.parse(response.body)['data']
      expect(body['attributes']['good_solutions']).to eq ['Testy']
      expect(body['attributes']['bad_solutions']).to be_empty
      expect(body['attributes']['solutions_size']).to eq 1
    end

    it 'allows only one answer per riddle' do
      user = create(:user)
      event = create(:event)
      participation = create(:participation, event: event)
      crypto_participation = create(:crypto_participation, participation: participation)
      crypto_challenge = create(:crypto_challenge, event: event)
      create(:crypto_riddle, crypto_challenge: crypto_challenge, solution: 'test')
      create(:crypto_riddle_solution, crypto_participation: crypto_participation,
                                      crypto_challenge: crypto_challenge, answer: 'test')
      create(:crypto_riddle_solution, crypto_participation: crypto_participation,
                                      crypto_challenge: crypto_challenge, answer: 'test')
      get "/api/v1/crypto/participations/#{crypto_participation.id}", headers: auth_headers(user)
      body = JSON.parse(response.body)['data']
      expect(body['attributes']['good_solutions']).to eq ['test']
      expect(body['attributes']['bad_solutions']).to eq ['test']
      expect(body['attributes']['good_solutions_size']).to eq 1
      expect(body['attributes']['bad_solutions_size']).to eq 1
      expect(body['attributes']['solutions_size']).to eq 2
    end
  end

  describe 'index' do
    it 'shows empty particpations list' do
      get '/api/v1/crypto/participations/', headers: json_api_headers
      expect(response).to have_http_status :ok

      expect(JSON.parse(response.body)['data']).to be_nil
    end

    it 'shows people results' do
      event = create(:event)
      participation = create(:participation, event: event)
      crypto_participation = create(:crypto_participation, participation: participation)
      crypto_challenge = create(:crypto_challenge, event: event)
      create(:crypto_riddle, crypto_challenge: crypto_challenge, solution: 'test')
      create(:crypto_riddle_solution, crypto_participation: crypto_participation,
                                      crypto_challenge: crypto_challenge, answer: 'test')
      create(:crypto_riddle_solution, crypto_participation: crypto_participation,
                                      crypto_challenge: crypto_challenge, answer: 'coś zupełnie innego')
      get '/api/v1/crypto/participations/', headers: json_api_headers
      expect(response).to have_http_status :ok

      expect((JSON.parse(response.body)['data']).size).to eq 1
      participation = JSON.parse(response.body)['data'].first
      expect(participation['attributes']['good_solutions_size']).to eq 1
      expect(participation['attributes']['bad_solutions_size']).to eq 1
      expect(participation['attributes']['solutions_size']).to eq 2
      expect(participation['attributes'].keys.include?('good_solutions')).to be(false)
      expect(participation['attributes'].keys.include?('bad_solutions')).to be(false)
    end

    it 'shows own detailed results' do
      user = create(:user)
      event = create(:event)
      participation = create(:participation, user: user, event: event)
      crypto_participation = create(:crypto_participation, participation: participation)
      crypto_challenge = create(:crypto_challenge, event: event)
      create(:crypto_riddle, crypto_challenge: crypto_challenge, solution: 'test')
      create(:crypto_riddle_solution, crypto_participation: crypto_participation,
                                      crypto_challenge: crypto_challenge, answer: 'test')
      create(:crypto_riddle_solution, crypto_participation: crypto_participation,
                                      crypto_challenge: crypto_challenge, answer: 'coś zupełnie innego')
      get '/api/v1/crypto/participations/', headers: auth_headers(user)
      expect(response).to have_http_status :ok

      expect((JSON.parse(response.body)['data']).size).to eq 1
      participation = JSON.parse(response.body)['data'].first
      expect(participation['attributes']['good_solutions']).to eq ['test']
      expect(participation['attributes']['bad_solutions']).to eq ['coś zupełnie innego']
    end

    it 'shows people results in proper order' do
      event = create(:event)
      participation = create(:participation, event: event)
      crypto_participation = create(:crypto_participation, participation: participation)
      crypto_participation2 = create(:crypto_participation, participation: participation)
      crypto_challenge = create(:crypto_challenge, event: event)
      create(:crypto_riddle, crypto_challenge: crypto_challenge, solution: 'test')
      create(:crypto_riddle, crypto_challenge: crypto_challenge, solution: 'rozwiązanie')
      create(:crypto_riddle_solution, crypto_participation: crypto_participation,
                                      crypto_challenge: crypto_challenge, answer: 'test')
      create(:crypto_riddle_solution, crypto_participation: crypto_participation,
                                      crypto_challenge: crypto_challenge, answer: 'to jest złe')
      create(:crypto_riddle_solution, crypto_participation: crypto_participation,
                                      crypto_challenge: crypto_challenge, answer: 'to też jest złe')
      create(:crypto_riddle_solution, crypto_participation: crypto_participation2,
                                      crypto_challenge: crypto_challenge, answer: 'test')
      create(:crypto_riddle_solution, crypto_participation: crypto_participation2,
                                      crypto_challenge: crypto_challenge, answer: 'rozwiązanie')
      get '/api/v1/crypto/participations/', headers: json_api_headers
      expect(response).to have_http_status :ok

      expect((JSON.parse(response.body)['data']).size).to eq 2
      participation = JSON.parse(response.body)['data'].first
      expect(participation['attributes']['good_solutions_size']).to eq 2
      expect(participation['attributes']['bad_solutions_size']).to eq 0
      expect(participation['attributes']['solutions_size']).to eq 2
      participation = JSON.parse(response.body)['data'].last
      expect(participation['attributes']['good_solutions_size']).to eq 1
      expect(participation['attributes']['bad_solutions_size']).to eq 2
      expect(participation['attributes']['solutions_size']).to eq 3
    end
  end
end
