class CreateGpxTracks < ActiveRecord::Migration[6.0]
  def change
    create_table :gpx_tracks do |t|
      t.references :participation, null: false, foreign_key: true
      t.float :total_ascent
      t.float :total_distance

      t.timestamps
    end
  end
end
