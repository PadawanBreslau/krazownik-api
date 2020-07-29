Trestle.resource(:bonus_points) do
  scope :all
  scope :following, dafault: true

  menu do
    item :bonus_points, icon: 'fa fa-exclamation'
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
    select :event_id, Event.all.map(&:id), label: 'Event'

    active_storage_field :image
  end
end
