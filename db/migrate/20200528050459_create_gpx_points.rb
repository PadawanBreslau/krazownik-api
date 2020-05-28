class CreateGpxPoints < ActiveRecord::Migration[6.0]
  def change
    create_table :gpx_points do |t|
      t.float :lat
      t.float :lng
      t.integer :counter, default: 1, null: false

      t.timestamps
    end

    create_table :gpx_points_participations do |t|
      t.references :participation, null: false, foreign_key: true
      t.references :gpx_point, null: false, foreign_key: true

      t.timestamps
    end
  end
end
