class ParticipationSerializer
  include FastJsonapi::ObjectSerializer
  include ImageHelper

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

  attribute :user_id do |object|
    object.user.id
  end

  attribute :year do |object|
    object.event.year
  end

  attribute :event_started do |object|
    object.event.started?
  end

  attribute :avatar do |object|
    image_path(object: object.user, image_field: :avatar, resize: '120x120')
  end

  attributes :total_distance_points, :total_ascent_points
end
