class AddMultiplierToTracks < ActiveRecord::Migration[6.0]
  def change
    add_column :gpx_tracks, :multiplier, :float, default: 1.0, null: false
  end
end
