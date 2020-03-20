class AddSentToRiddles < ActiveRecord::Migration[6.0]
  def change
    add_column :riddles, :sent, :boolean, default: false
  end
end
