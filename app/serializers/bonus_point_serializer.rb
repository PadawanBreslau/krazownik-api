class BonusPointSerializer
  include FastJsonapi::ObjectSerializer
  include ImageHelper

  set_key_transform :underscore
  set_type :bonus_point
  set_id :id

  attribute :name, :region, :lat, :lon, :points, :completed

  has_many :bonus_point_completions
end
