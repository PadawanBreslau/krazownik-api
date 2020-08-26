class AddDefaultValueForTrackFileMetadata < ActiveRecord::Migration[6.0]
  def change
    change_column_default :track_files, :metadata, from: nil, to: {}
  end
end
