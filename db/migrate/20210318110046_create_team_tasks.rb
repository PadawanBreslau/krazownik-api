class CreateTeamTasks < ActiveRecord::Migration[6.0]
  def change
    create_table :team_tasks do |t|
      t.string :content, null: false
      t.text :description
      t.integer :amount, null: false
      t.boolean :approved_by_leader, default: false
      t.references :team, null: false, foreign_key: true

      t.timestamps
    end
  end
end
