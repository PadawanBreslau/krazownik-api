Trestle.resource(:track_files) do
  scope :all

  User.where(id: TrackFile.all.map(&:user_id))&.each do |u|
    scope u.unique_name.to_sym, label: u.name
  end

  menu do
    item :track_files, icon: 'fa fa-exclamation'
  end

  form do |_object|
    select :user_id, User.all.map { |u| [u.name, u.id] }, label: 'Author'
    select :event_id, Event.all.map { |e| [e.year, e.id] }, label: 'Year'
  end
end
