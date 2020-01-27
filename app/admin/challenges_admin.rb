Trestle.resource(:challenges) do
  menu do
    item :challenges, icon: 'fa fa-star'
  end

  active_storage_fields do
    [:icon]
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
  form do |_challenge|
    text_field :title
    text_area :description
    text_field :points
    check_box :open
    select :event_id, Event.all, label: 'Event'
    active_storage_field :icon

    #
    #   row do
    #     col(xs: 6) { datetime_field :updated_at }
    #     col(xs: 6) { datetime_field :created_at }
    #   end
  end

  # By default, all parameters passed to the update and create actions will be
  # permitted. If you do not have full trust in your users, you should explicitly
  # define the list of permitted parameters.
  #
  # For further information, see the Rails documentation on Strong Parameters:
  #   http://guides.rubyonrails.org/action_controller_overview.html#strong-parameters
  #
  # params do |params|
  #   params.require(:challenge).permit(:name, ...)
  # end
end
