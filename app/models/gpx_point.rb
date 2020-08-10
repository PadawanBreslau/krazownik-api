class GpxPoint < ApplicationRecord
  SAME_POINT_APPROXIMATION_DISTANCE = 0.25

  has_and_belongs_to_many :participations

  def close_enough?(lat, lon)
    Geokit::LatLng.new(self.lat, self.lon)
                  .distance_to("#{lat}, #{lon}").round(2) < SAME_POINT_APPROXIMATION_DISTANCE
  end

  def color
    "##{green}#{green}FF"
  end

  def green
    val = [(0xAA - counter * 12), 0].max
    val > 9 ? val.to_s(16) : "0#{val}"
  end
end
