class CreateEvents < ActiveRecord::Migration[6.0]
  def change
    create_table :events do |t|
      t.integer :year
      t.jsonb :informations

      t.timestamps
    end
  end
end
