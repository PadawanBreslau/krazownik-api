Trestle.resource(:events) do
  menu do
    group :event do
      item :events, icon: 'fa fa-star'
    end
  end

  form dialog: true do |_event|
    tab :basic do
      row do
        col { number_field :year }
        col { datetime_field :start_time }
      end

      row do
        col { text_field :place }
        col { text_field :base_location }
      end

      row do
        col { text_field :lat }
        col { text_field :lon }
      end
    end

    tab :urls do
      text_field :url
      text_field :regulations_url
      text_field :fb_event_url
    end
  end
end
