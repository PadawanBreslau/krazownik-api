class CreatePhotos < ActiveRecord::Migration[6.0]
  def change
    create_table :photos do |t|
      t.integer :user_id, null: false
      t.integer :event_id, null: false
      t.datetime :creation_time

      t.timestamps
    end
  end
end
