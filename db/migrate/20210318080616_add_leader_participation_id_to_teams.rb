class AddLeaderParticipationIdToTeams < ActiveRecord::Migration[6.0]
  def change
    add_column :teams, :leader_participation_id, :integer
  end
end
