class MoveTeamReadyToUsers < ActiveRecord::Migration[6.0]
  def change
    remove_column :participations, :team_ready, :boolean
    add_column :users, :team_ready, :boolean, default: false
  end
end
