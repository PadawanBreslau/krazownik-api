class TeamTaskPhoto < ApplicationRecord
  belongs_to :user
  belongs_to :team_task

  has_one_attached :photo

  def toggle_accept!
    update(accept: !accept)
  end
end
