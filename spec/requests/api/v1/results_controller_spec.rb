require 'rails_helper'

describe Api::V1::ResultsController do
  describe 'index' do
    it 'shows results - bonus points' do
      event = create(:event, start_time: Time.current - 10.days)
      p1 = create(:participation, event: event)
      p2 = create(:participation, event: event)

      b1 = create(:bonus_point, event: event, points: 5)
      b2 = create(:bonus_point, event: event, points: 8)

      create :bonus_point_completion, participation: p1, bonus_point: b1
      create :bonus_point_completion, participation: p2, bonus_point: b2

      p1.touch
      p2.touch

      get '/api/v1/results', headers: json_api_headers
      expect(response).to have_http_status :ok

      body = JSON.parse(response.body)['data']
      expect(body.size).to eq 2
      expect(body.first.dig('attributes', 'total')).to eq 8.0
      expect(body.first.dig('attributes', 'result', 'points_from_bonus_points')).to eq 8.0
      expect(body.last.dig('attributes', 'total')).to eq 5.0
      expect(body.last.dig('attributes', 'result', 'points_from_bonus_points')).to eq 5.0
    end

    it 'shows results - challenges' do
      event = create(:event, start_time: Time.current - 10.days)
      p1 = create(:participation, event: event)
      p2 = create(:participation, event: event)

      c1 = create(:challenge, event: event, points: 8)
      c2 = create(:challenge, event: event, points: 12)

      create :challenge_completion, participation: p1, challenge: c1
      create :challenge_completion, participation: p2, challenge: c2
      create :challenge_completion, participation: p1, challenge: c2

      p1.touch
      p2.touch

      get '/api/v1/results', headers: json_api_headers
      expect(response).to have_http_status :ok

      body = JSON.parse(response.body)['data']
      expect(body.size).to eq 2
      expect(body.first.dig('attributes', 'total')).to eq 20.0
      expect(body.first.dig('attributes', 'result', 'points_from_challenges')).to eq 20.0
      expect(body.last.dig('attributes', 'total')).to eq 12.0
      expect(body.last.dig('attributes', 'result', 'points_from_challenges')).to eq 12.0
    end

    it 'shows results - extra' do
      event = create(:event, start_time: Time.current - 10.days)
      p1 = create(:participation, event: event)
      p2 = create(:participation, event: event)

      create(:extra, participation: p1, points: 24)
      create(:extra, participation: p2, points: 16)

      p1.touch
      p2.touch

      get '/api/v1/results', headers: json_api_headers
      expect(response).to have_http_status :ok

      body = JSON.parse(response.body)['data']
      expect(body.size).to eq 2
      expect(body.first.dig('attributes', 'total')).to eq 24.0
      expect(body.first.dig('attributes', 'result', 'extra_points')).to eq 24.0
      expect(body.last.dig('attributes', 'total')).to eq 16.0
      expect(body.last.dig('attributes', 'result', 'extra_points')).to eq 16.0
    end

    it 'shows results - combined' do
      event = create(:event, start_time: Time.current - 10.days)
      p1 = create(:participation, event: event)

      b1 = create(:bonus_point, event: event, points: 5)
      c1 = create(:challenge, event: event, points: 8)
      create(:extra, participation: p1, points: 24)

      create :challenge_completion, participation: p1, challenge: c1
      create :bonus_point_completion, participation: p1, bonus_point: b1

      p1.touch

      get '/api/v1/results', headers: json_api_headers
      expect(response).to have_http_status :ok

      body = JSON.parse(response.body)['data']
      expect(body.size).to eq 1
      expect(body.first.dig('attributes', 'total')).to eq 37.0
      expect(body.first.dig('attributes', 'result', 'points_from_bonus_points')).to eq 5.0
      expect(body.first.dig('attributes', 'result', 'points_from_challenges')).to eq 8.0
      expect(body.first.dig('attributes', 'result', 'extra_points')).to eq 24.0
    end
  end
end
