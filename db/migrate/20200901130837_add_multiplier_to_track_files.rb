class AddMultiplierToTrackFiles < ActiveRecord::Migration[6.0]
  def change
    add_column :track_files, :multiplier, :float, default: 1.0, null: false
  end
end
