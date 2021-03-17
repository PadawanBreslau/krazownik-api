require 'rails_helper'

RSpec.describe CryptoChallenge do
  it 'creates simple challenge' do
    crypto_challenge = create(:crypto_challenge)
    expect(crypto_challenge.crypto_participations).to be_empty
    expect(crypto_challenge.finished?).to be(false)
  end

  it 'creates simple challenge and adds riddles' do
    crypto_challenge = create(:crypto_challenge)
    create_list(:crypto_riddle, 5, crypto_challenge: crypto_challenge, solution: Faker::Lorem.word)
    expect(crypto_challenge.crypto_participations).to be_empty
    expect(crypto_challenge.finished?).to be(false)
    expect(crypto_challenge.crypto_riddles.size).to eq 5
  end

  it 'creates simple challenge, adds riddles and participants answers' do
    event = create(:event)
    crypto_challenge = create(:crypto_challenge, event: event)
    create_list(:crypto_riddle, 5, crypto_challenge: crypto_challenge, solution: Faker::Lorem.word)
    participation = create(:participation, event: event)
    crypto_participation = create(:crypto_participation, participation: participation)

    create(:crypto_riddle_solution, crypto_participation: crypto_participation, crypto_challenge: crypto_challenge, answer: 'tatanka')
    expect(crypto_challenge.crypto_participations).to eq [crypto_participation]
    expect(crypto_challenge.finished?).to be(false)
    expect(crypto_challenge.crypto_riddles.size).to eq 5
    expect(crypto_participation.good_solutions.size).to eq 0
    expect(crypto_participation.bad_solutions.size).to eq 1
  end

  it 'creates challenge, answer all questions' do
  end
end
