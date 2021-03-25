class TeamTask < ApplicationRecord
  belongs_to :team

  has_many :team_task_photos
end
