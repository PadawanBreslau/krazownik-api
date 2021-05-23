Trestle.resource(:participations) do
  scope :all
  scope :current, default: true

  menu do
    group :event do
      item :participations, icon: 'fa fa-star'
    end
  end

  table(autolink: false) do
    column :event do |object|
      object.event.year
    end

    column :name do |object|
      object.user.name
    end

    column :email do |object|
      object.user.email
    end

    column :team do |object|
      object.team&.name
    end

    column :team_ready do |object|
      object.user.team_ready
    end

    column :phone do |object|
      object.user.phone_number
    end

    actions do |toolbar, instance, admin|
      toolbar.edit
    end
  end
end
