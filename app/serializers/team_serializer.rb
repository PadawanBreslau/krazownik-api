class TeamSerializer
  include FastJsonapi::ObjectSerializer
  include ImageHelper

  set_key_transform :underscore
  set_type :teams
  set_id :id

  attribute :name

  attribute :emblem do |object|
    image_path(object: object, image_field: :emblem, resize: '200x200')
  end

  attribute :own do |object, params|
    params[:user]&.belongs_to?(object) || false
  end

  attribute :leader do |obejct, params|
    params[:user]&.current_participation&.id == obejct.leader_participation_id
  end

  has_many :participations
  has_many :team_tasks, if: Proc.new { Event.current.started? }
end
