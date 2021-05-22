Trestle.resource(:challenges) do
  scope :all
  scope :hidden
  scope :following, default: true

  menu do
    group :challenges do
      item :challenges, icon: 'fa fa-cubes'
    end
  end

  active_storage_fields do
    [:icon]
  end

  form do
    row do
      col { text_field :title }
      col { text_field :points }
      col { select :event_id, Event.all, label: 'Event' }
    end

    row do
      col { text_area :description }
    end

    row do
      col(sm: 2) { check_box :open }
      col(sm: 2) { active_storage_field :icon }
    end
  end
end
