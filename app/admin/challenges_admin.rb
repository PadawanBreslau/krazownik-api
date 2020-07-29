Trestle.resource(:challenges) do
  scope :all
  scope :following, dafault: true

  menu do
    item :challenges, icon: 'fa fa-exclamation'
  end

  active_storage_fields do
    [:icon]
  end

  form do |_challenge|
    text_field :title
    text_area :description
    text_field :points
    check_box :open
    select :event_id, Event.all, label: 'Event'
    active_storage_field :icon
  end
end
