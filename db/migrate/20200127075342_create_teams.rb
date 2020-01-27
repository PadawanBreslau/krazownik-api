class CreateTeams < ActiveRecord::Migration[6.0]
  def change
    create_table :teams do |t|
      t.string :name

      t.timestamps
    end

    add_column :users, :team_id, :integer
  end
end
