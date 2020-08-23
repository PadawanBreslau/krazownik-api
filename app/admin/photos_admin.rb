Trestle.resource(:photos) do
  scope :all

  User.where(id: Photo.all.map(&:user_id))&.each do |u|
    scope u.unique_name.to_sym, label: u.name
  end

  menu do
    item :photos, icon: 'fa fa-exclamation'
  end

  active_storage_fields do
    [:photo_image]
  end

  form do |_object|
    select :user_id, User.all.map { |u| [u.name, u.id] }, label: 'Author'
    select :event_id, Event.all.map { |e| [e.year, e.id] }, label: 'Year'

    datetime_field :creation_time
    active_storage_field :photo_image
  end
end
