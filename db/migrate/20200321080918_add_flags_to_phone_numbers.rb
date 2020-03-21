class AddFlagsToPhoneNumbers < ActiveRecord::Migration[6.0]
  def change
    add_column :phone_numbers, :send_riddles, :boolean, default: true
    add_column :phone_numbers, :send_messages, :boolean, default: true
  end
end
