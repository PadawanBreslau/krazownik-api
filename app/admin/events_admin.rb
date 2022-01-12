Trestle.resource(:events) do
  menu do
    group :event do
      item :events, icon: 'fa fa-etsy'
    end
  end

  table do
    column :year
    column :start_time
    column :place
    column :base_location
    column :base_address
  end

  form dialog: true do
    tab :basic do
      row do
        col { number_field :year }
        col { datetime_field :start_time }
        col { text_field :phone }
      end

      row do
        col { text_field :place }
        col { text_field :base_location }
        col { text_field :base_address }
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
