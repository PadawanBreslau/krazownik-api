Trestle.resource(:users) do
  menu do
    item :users, icon: 'fa fa-star'
  end

   scope :all
   scope :current, -> { User.left_joins(:participations).where('event_id = ?', Event.current.id) }, default: true


  search do |query|
    if query
      User.where("name ILIKE ? OR email ILIKE ?", "%#{query}%", "%#{query}%")
    else
      User.all
    end
  end

  table do
    column :email
    column :name
    column :nickname
    column :phone_number
    column :team_ready
    column :send_messages
    column :send_riddles
    column :about_me
  end

  form do
    text_field :name
    text_field :nickname
    text_field :phone_number
    check_box :team_ready
    check_box :send_messages
    check_box :send_riddles
    text_area :about_me
  end
end
