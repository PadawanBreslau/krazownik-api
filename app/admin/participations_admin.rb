Trestle.resource(:participations) do
  scope :all
  scope :current, default: true

  menu do
    group :event do
      item :participations, icon: 'fa fa-star'
    end
  end
end
