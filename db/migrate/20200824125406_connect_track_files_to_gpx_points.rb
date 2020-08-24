class ConnectTrackFilesToGpxPoints < ActiveRecord::Migration[6.0]
  def change
    create_table :gpx_points_track_files do |t|
      t.references :track_file, null: false, foreign_key: true
      t.references :gpx_point, null: false, foreign_key: true

      t.timestamps
    end
  end
end
