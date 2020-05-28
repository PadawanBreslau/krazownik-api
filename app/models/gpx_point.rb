class GpxPoint < ApplicationRecord
  SAME_POINT_APPROXIMATION_DISTANCE = 0.2

  has_and_belongs_to_many :participations

  def close_enough?(lat, _lng)
    Geokit::LatLng.new(self.lat, lgt)
                  .distance_to(lat, lgt).round(2) < SAME_POINT_APPROXIMATION_DISTANCE
  end

  def color
    "#{green}FF00"
  end

  def green
    0xFF - counter * 8
  end
end
