class CreateBonusPointParticipations < ActiveRecord::Migration[6.0]
  def change
    create_table :bonus_point_participations do |t|
      t.references :bonus_point, null: false, foreign_key: true
      t.references :participation, null: false, foreign_key: true

      t.timestamps
    end
  end
end
