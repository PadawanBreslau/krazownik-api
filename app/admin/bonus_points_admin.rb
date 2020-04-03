Trestle.resource(:bonus_points) do
  menu do
    item :bonus_points, icon: 'fa fa-star'
  end

  active_storage_fields do
    [:image]
  end

  form do |_bonus_point|
    text_field :name
    text_field :region
    text_field :points
    text_field :lat
    text_field :lng

    active_storage_field :image
  end
end
