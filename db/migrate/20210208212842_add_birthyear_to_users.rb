class AddBirthyearToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :birthyear, :integer
  end
end
