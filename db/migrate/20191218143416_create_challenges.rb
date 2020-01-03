class CreateChallenges < ActiveRecord::Migration[6.0]
  def change
    create_table :challenges do |t|
      t.string :title
      t.string :description
      t.boolean :open
      t.references :event, null: false, foreign_key: true

      t.timestamps
    end
  end
end
