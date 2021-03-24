class Team < ApplicationRecord
  has_many :participations, dependent: :nullify
  has_many :team_tasks, dependent: :nullify
  belongs_to :event

  has_one_attached :emblem

  def self.current
    Event.current.teams
  end

  def leader
    Participation.find_by(id: leader_participation_id)
  end

  def photos
    ActiveStorage::Attachment.where(name: 'photos', record_type: 'Participation', record_id: participations.map(&:id))
  end

  def photo_ids
    photos.map(&:id)
  end

  def visible?
    return false unless event.start_time

    event.start_time - Time.current < 11.months && event.start_time > Time.current + 1.month
  end
end
