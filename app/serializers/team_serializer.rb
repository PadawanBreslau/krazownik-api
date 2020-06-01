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

  has_many :participations
  has_many :photos
end
