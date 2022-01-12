Trestle.resource(:team_tasks) do
  menu do
    group :teams do
      item :team_tasks, icon: 'fa fa-star'
    end
  end

  form do |team_task|
    row do
      col { text_field :content }
      col { number_field :amount }
      col { check_box :approved_by_leader, readonly: true }
      col { select :team_id, Team.current.map { |t| [t.name, t.id] }, label: 'Team' }
    end

    row do
      col { text_area :description }
    end
  end
end
