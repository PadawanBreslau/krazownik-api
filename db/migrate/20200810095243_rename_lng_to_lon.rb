class RenameLngToLon < ActiveRecord::Migration[6.0]
  def change
    rename_column :bonus_points, :lng, :lon
    rename_column :gpx_points, :lng, :lon
  end
end
