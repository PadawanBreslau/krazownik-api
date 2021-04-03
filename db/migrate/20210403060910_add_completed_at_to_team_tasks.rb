class AddCompletedAtToTeamTasks < ActiveRecord::Migration[6.0]
  def change
    add_column :team_tasks, :completed_at, :datetime
  end
end
