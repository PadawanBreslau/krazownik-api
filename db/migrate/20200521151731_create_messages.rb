class CreateMessages < ActiveRecord::Migration[6.0]
  def change
    create_table :messages do |t|
      t.string :content
      t.datetime :sent_at

      t.boolean :sent, default: false
      t.timestamps
    end
  end
end
