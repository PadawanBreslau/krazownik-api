class CreateBonusPoints < ActiveRecord::Migration[6.0]
  def change
    create_table :bonus_points do |t|
      t.string :name, null: false
      t.decimal :lat, precision: 10, scale: 6, null: false
      t.decimal :lng, precision: 10, scale: 6, null: false
      t.string :region
      t.integer :points

      t.references :event, null: false, foreign_key: true
      t.timestamps
    end
  end
end
