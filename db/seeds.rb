# frozen_string_literal: true
#a

Team.delete_all
Riddle.delete_all
BonusPoint.delete_all
Participation.delete_all
User.delete_all
ChallengeCondition.delete_all
Challenge.delete_all
Event.delete_all


Event.create(year: 2019)
ev = Event.create(year: 2020)
ev21 = Event.create(year: 2021)

c = Challenge.create(title: 'Red is bad', description: Faker::Lorem.sentence, event: ev, points: 3, open: false )
Challenge.create(title: 'Krążownik', description: Faker::Lorem.sentence, event: ev, points: 8, open: true)
Challenge.create(title: 'O jeden mosr za daleko', description: Faker::Lorem.sentence, event: ev, points: 12, open: true)
c4 = Challenge.create(title: 'Sunset Boulevard', description: Faker::Lorem.sentence, event: ev, points: 5, open: false )
Challenge.create(title: 'House of the rising', description: Faker::Lorem.sentence, event: ev, points: 5, open: false )

ChallengeCondition.create(challenge: c, content: Faker::Lorem.sentence)
ChallengeCondition.create(challenge: c, content: Faker::Lorem.sentence)

u = User.create(email: 'test@test.com', uid: 'test@test.com', password: 'password', name: 'test', nickname: 'test')

team = Team.create(name: 'Arsenal', event: ev)
participation = Participation.create(user: u, event: ev, team_id: team.id)
participation21 = Participation.create(user: u, event: ev21)

BonusPoint.create(name: 'Turbacz', region: 'Gorce', points: 25, event: ev, lat: 0.0, lng: 0.0)
BonusPoint.create(name: 'Lubań', region: 'Gorce', points: 15, event: ev, lat: 0.0, lng: 0.0)
BonusPoint.create(name: 'Wysoka', region: 'Pieniny', points: 5, event: ev, lat: 0.0, lng: 0.0)
BonusPoint.create(name: 'Trzy Korony', region: 'Pieniny', points: 5, event: ev, lat: 0.0, lng: 0.0)

ChallengeCompletion.create(challenge: c, participation: participation, completed: false)
ChallengeCompletion.create(challenge: c4, participation: participation, completed: false)

Riddle.create(title: 'Test', content: Faker::Lorem.sentence, answer: Faker::Lorem.sentence, visible_from: Time.current + 5.hours, event: ev )
Riddle.create(title: 'Test Visible', content: Faker::Lorem.sentence, answer: Faker::Lorem.sentence, visible_from: Time.current - 5.hours, event: ev )

puts 'Done'
