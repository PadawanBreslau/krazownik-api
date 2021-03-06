class BonusPointSerializer
  include FastJsonapi::ObjectSerializer
  include ImageHelper

  set_key_transform :underscore
  set_type :bonus_point
  set_id :id

  attribute :name, :region, :lat, :lon, :points, :completed

  attribute :photo do |object|
    image_path(object: object, image_field: :image, resize: '200x200')
  end

  #  has_many :participations
  has_many :bonus_point_completions
end
