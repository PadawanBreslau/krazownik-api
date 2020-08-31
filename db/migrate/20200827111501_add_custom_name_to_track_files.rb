class AddCustomNameToTrackFiles < ActiveRecord::Migration[6.0]
  def change
    add_column :track_files, :custom_name, :string
  end
end
