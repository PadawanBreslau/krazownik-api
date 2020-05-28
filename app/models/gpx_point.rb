class GpxPoint < ApplicationRecord
  SAME_POINT_APPROXIMATION_DISTANCE = 0.25

  has_and_belongs_to_many :participations

  def close_enough?(lat, lgt)
    Geokit::LatLng.new(self.lat, self.lgt)
                  .distance_to("#{lat}, #{lgt}").round(2) < SAME_POINT_APPROXIMATION_DISTANCE
  end

  def color
    "#{green}FF00"
  end

  def green
    val = [(0xFF - counter * 12), 0].max
    val > 9 ? val.to_s(16):  "0#{val}"
  end
end
