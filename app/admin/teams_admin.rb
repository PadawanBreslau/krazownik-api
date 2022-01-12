Trestle.resource(:teams) do
  menu do
    group :teams do
      item :teams, icon: 'fa fa-flag'
    end
  end

  scope :current, -> { Team.current }, default: true
  scope :all

  active_storage_fields do
    [:emblem]
  end

  form do |team|
    tab :basic do
      row do
        col { text_field :name }
        col { select :leader_participation_id, team.participations.map { |t| [t.name, t.id] }, label: 'Leader' } if team.persisted?
        col { select :event_id, Event.all.map { |e| [e.year, e.id] }, label: 'Event' }
      end

      row do
        active_storage_field :emblem
      end
    end

    tab :participations, badge: team.participations.size do
      table team.participations, admin: :participations do
        column :name, link: true

        actions
      end
    end

    tab :tasks, badge: team.team_tasks.size do
      table team.team_tasks, admin: :team_tasks do
        column :content, link: true
        column :amount
        column :completed_at

        actions
      end
    end
  end
end
