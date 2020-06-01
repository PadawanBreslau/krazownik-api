class Team < ApplicationRecord
  has_many :participations, -> { where team_ready: true }, dependent: :nullify
  belongs_to :event

  has_one_attached :emblem

  def photos
    ActiveStorage::Attachment.where(name: 'photos', record_type: 'Participation', record_id: participations.map(&:id))
  end

  def photo_ids
    photos.map(&:id)
  end
end
