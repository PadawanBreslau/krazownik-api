class ParticipationSerializer
  include FastJsonapi::ObjectSerializer

  set_key_transform :underscore
  set_type :participation
  set_id :id

  has_one :extra
  has_one :team
  has_many :challenges
  has_many :challenge_completions
  has_many :bonus_points
  has_many :bonus_point_completions
  has_many :gpx_points

  attribute :user do |object|
    object.user.name
  end

  attribute :year do |object|
    object.event.year
  end

  attribute :event_started do |object|
    object.event.started?
  end

  attributes :total_distance_points, :total_ascent_points
end
