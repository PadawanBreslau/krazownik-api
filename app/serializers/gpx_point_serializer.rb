class GpxPointSerializer
  include FastJsonapi::ObjectSerializer

  attributes :lat, :lon, :counter, :color
end
