class MovePhoneInfoToUsers < ActiveRecord::Migration[6.0]
  def change
    reversible do |dir|
      dir.up do
        drop_table :phone_numbers
      end
    end

    add_column :users, :phone_number, :string
    add_column :users, :send_riddles, :boolean, default: true
    add_column :users, :send_messages, :boolean, default: true
  end
end
