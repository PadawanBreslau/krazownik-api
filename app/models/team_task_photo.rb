class TeamTaskPhoto < ApplicationRecord
  belongs_to :user
  belongs_to :team_task

  has_one_attached :photo

  def toggle_accept!
    update(accepted: !accepted)

    team_task.complete_task if accepted && team_task.all_accepted?
  end
end
