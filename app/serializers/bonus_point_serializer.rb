class BonusPointSerializer
  include FastJsonapi::ObjectSerializer

  set_key_transform :underscore
  set_type :bonus_point
  set_id :id

  attribute :name, :region, :lat, :lng, :points

  has_many :participations
end
