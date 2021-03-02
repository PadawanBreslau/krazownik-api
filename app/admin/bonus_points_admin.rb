Trestle.resource(:bonus_points) do
  scope :all
  scope :following, default: true

  menu do
    group :bonus_point do
      item :bonus_points, icon: 'fa fa-globe'
    end
  end

  active_storage_fields do
    [:image]
  end

  form do
    row do
      col { text_field :name }
      col { text_field :region }
    end

    row do
      col { text_field :points }
      col {  text_field :lat }
      col { text_field :lon }
      col { select :event_id, Event.all.map { |e| [e.year, e.id] }, label: 'Event' }
    end
    #   active_storage_field :image
  end
end
