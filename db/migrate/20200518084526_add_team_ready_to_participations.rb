class AddTeamReadyToParticipations < ActiveRecord::Migration[6.0]
  def change
    add_column :participations, :team_ready, :boolean, default: true
  end
end
