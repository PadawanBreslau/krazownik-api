Trestle.resource(:teams) do
  menu do
    item :teams, icon: 'fa fa-star'
  end

  active_storage_fields do
    [:emblem]
  end

  form do |_bonus_point|
    text_field :name
    active_storage_field :emblem
  end
end
