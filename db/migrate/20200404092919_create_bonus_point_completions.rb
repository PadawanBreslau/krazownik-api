class CreateBonusPointCompletions < ActiveRecord::Migration[6.0]
  def change
    create_table :bonus_point_completions do |t|
      t.references :participation, null: false, foreign_key: true
      t.references :bonus_point, null: false, foreign_key: true
      t.boolean :completed, default: false

      t.timestamps
    end
  end
end
