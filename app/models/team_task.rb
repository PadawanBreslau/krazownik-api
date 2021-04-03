class TeamTask < ApplicationRecord
  belongs_to :team

  has_many :team_task_photos

  def all_accepted?
    team_task_photos.all?(&:accepted) && team_task_photos.size == amount
  end

  def complete_task
    update(completed_at: Time.current)

    team.complete_team_tasks! if team.team_tasks.all?{|tt| tt.completed_at.present?}
  end
end
