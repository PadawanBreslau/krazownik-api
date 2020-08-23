class CreateTrackFiles < ActiveRecord::Migration[6.0]
  def change
    create_table :track_files do |t|
      t.integer :user_id, null: false
      t.integer :event_id, null: false
      t.jsonb :metadata

      t.timestamps
    end
  end
end
