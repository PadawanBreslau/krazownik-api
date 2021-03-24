require 'rails_helper'

RSpec.describe Team do
  it 'creates an empty team' do
    event = create(:event)
    team = create(:team, event: event, name: 'Arsenal')
    expect(team.visible?).to be(true)
  end

  it 'creates a team and adds people' do
    event = create(:event)
    team = create(:team, event: event, name: 'Arsenal')
    user1 = create(:user)
    user2 = create(:user)
    p1 = create(:participation, event: event, user: user1, team_id: team.id)
    p2 = create(:participation, event: event, user: user2, team_id: team.id)

    expect(team.participations).to eq [p1, p2]
  end

  it 'sets up team leader' do
    event = create(:event)
    user1 = create(:user)
    user2 = create(:user)
    p1 = create(:participation, event: event, user: user1)
    p2 = create(:participation, event: event, user: user2)
    team = create(:team, event: event, name: 'Arsenal', leader_participation_id: p1.id)
    p1.update(team_id: team.id)
    p2.update(team_id: team.id)

    expect(team.participations).to eq [p1, p2]
    expect(team.leader).to eq p1
  end
end
