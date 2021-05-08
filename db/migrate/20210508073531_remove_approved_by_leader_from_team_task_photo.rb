class RemoveApprovedByLeaderFromTeamTaskPhoto < ActiveRecord::Migration[6.0]
  def change
    remove_column :team_task_photos, :approved_by_leader, :boolean
  end
end
