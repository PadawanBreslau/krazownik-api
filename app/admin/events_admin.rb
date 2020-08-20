Trestle.resource(:events) do
  menu do
    item :events, icon: 'fa fa-star'
  end

  form do |_event|
    number_field :year
    datetime_field :date
    text_field :place
    text_field :base_location
    text_field :lat
    text_field :lon
    text_field :url
    text_field :regulations_url
    text_field :fb_event_url
  end
end
