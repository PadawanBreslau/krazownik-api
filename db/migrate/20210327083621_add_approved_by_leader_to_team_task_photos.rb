class AddApprovedByLeaderToTeamTaskPhotos < ActiveRecord::Migration[6.0]
  def change
    add_column :team_task_photos, :approved_by_leader, :boolean, default: false
  end
end
