Trestle.resource(:teams) do
  menu do
    item :teams, icon: 'fa fa-star'
  end

  active_storage_fields do
    [:emblem]
  end

  form do |_bonus_point|
    text_field :name
    select :event_id, Event.all.map(&:id), label: 'Event'
    active_storage_field :emblem
  end
end
