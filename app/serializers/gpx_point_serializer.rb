class GpxPointSerializer
  include FastJsonapi::ObjectSerializer

  attributes :lat, :lng, :counter, :color
end
