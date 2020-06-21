class CreateResults < ActiveRecord::Migration[6.0]
  def change
    create_table :results do |t|
      t.references :participation, null: false, foreign_key: true
      t.jsonb :result
      t.float :total

      t.timestamps
    end
  end
end
