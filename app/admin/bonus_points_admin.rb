Trestle.resource(:bonus_points) do
  menu do
    item :bonus_points, icon: 'fa fa-star'
  end

  active_storage_fields do
    [:map_image]
  end

  # Customize the table columns shown on the index view.
  #
  # table do
  #   column :name
  #   column :created_at, align: :center
  #   actions
  # end

  # Customize the form fields shown on the new/edit views.
  #
  form do |_bonus_point|
    text_field :name
    text_field :region
    text_field :points
    text_field :lat
    text_field :lng

    active_storage_field :map_image

    #
    #   row do
    #     col(xs: 6) { datetime_field :updated_at }
    #     col(xs: 6) { datetime_field :created_at }
    #   end
  end
end
