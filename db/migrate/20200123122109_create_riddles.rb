class CreateRiddles < ActiveRecord::Migration[6.0]
  def change
    create_table :riddles do |t|
      t.string :title, null: false
      t.text :content, null: false
      t.text :answer
      t.datetime :visible_from

      t.timestamps
    end
  end
end
