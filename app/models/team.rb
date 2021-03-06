class Team < ApplicationRecord
  has_many :participations, dependent: :nullify
  has_many :team_tasks, dependent: :nullify
  has_many :team_tasks_photos, through: :team_tasks
  belongs_to :event

  has_one_attached :emblem

  def self.current
    Event.current.teams
  end

  def leader
    Participation.find_by(id: leader_participation_id)
  end

  def leader?(participation)
    leader == participation
  end

  def photos
    ActiveStorage::Attachment.where(name: 'photos', record_type: 'Participation', record_id: participations.map(&:id))
  end

  def photo_ids
    photos.map(&:id)
  end

  def visible?
    return false unless event.start_time

    event == Event.current
  end

  def complete_team_tasks!
    update(completed_at: Time.current)
    # send SMS to team
    # send SMS to me
  end
end
