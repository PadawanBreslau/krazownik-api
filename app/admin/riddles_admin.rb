Trestle.resource(:riddles) do
  scope :all
  scope :current, default: true

  menu do
    item :riddles, icon: 'fa fa-star'
  end
end
