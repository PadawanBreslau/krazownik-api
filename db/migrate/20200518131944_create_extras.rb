class CreateExtras < ActiveRecord::Migration[6.0]
  def change
    create_table :extras do |t|
      t.references :participation, null: false, foreign_key: true
      t.float :points

      t.timestamps
    end
  end
end
