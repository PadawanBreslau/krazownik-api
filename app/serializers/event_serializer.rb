class EventSerializer
  include FastJsonapi::ObjectSerializer

  set_key_transform :underscore
  set_type :event
  set_id :id

  attributes :year, :start_time, :informations
end
