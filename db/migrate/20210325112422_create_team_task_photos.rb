class CreateTeamTaskPhotos < ActiveRecord::Migration[6.0]
  def change
    create_table :team_task_photos do |t|
      t.boolean :accepted
      t.references :user, null: false, foreign_key: true
      t.references :team_task, null: false, foreign_key: true

      t.timestamps
    end
  end
end
