class AddViewableToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :viewable, :boolean, default: true
  end
end
