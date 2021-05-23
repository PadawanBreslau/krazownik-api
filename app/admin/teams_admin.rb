Trestle.resource(:teams) do
  menu do
    group :event do
      item :teams, icon: 'fa fa-star'
    end
  end

  scope :current, -> { Team.current }, default: true
  scope :all

  active_storage_fields do
    [:emblem]
  end

  form do |team|
    row do
      col { text_field :name }
      col { select :leader_participation_id, team.participations.map { |t| [t.name, t.id] }, label: 'Leader' } if team.persisted?
      col { select :event_id, Event.all.map { |e| [e.year, e.id] }, label: 'Event' }
    end

    row do
      active_storage_field :emblem
    end

    divider

    team.participations.map do |p|
      row do
        p.name
      end
    end
  end
end
