Trestle.resource(:participations) do
  scope :all
  scope :current, default: true

  menu do
    item :participations, icon: 'fa fa-star'
  end
end
