Trestle.resource(:users) do
  menu do
    item :users, icon: 'fa fa-star'
  end

  table do
    column :email
    column :name
    column :nickname
  end

  form do
    text_field :name
    text_field :nickname
  end
end
