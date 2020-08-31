class AddUnifiedToGpxPoints < ActiveRecord::Migration[6.0]
  def change
    add_column :gpx_points, :unified, :boolean, default: true
    add_column :gpx_points, :track_index, :integer
  end
end
