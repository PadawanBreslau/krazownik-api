Trestle.resource(:users) do
  menu do
    item :users, icon: 'fa fa-star'
  end

  table do
    column :email
    column :name
    column :nickname
    column :phone_number
    column :team_ready
    column :send_messages
    column :send_riddles
  end

  form do
    text_field :name
    text_field :nickname
    text_field :phone_number
  end
end
