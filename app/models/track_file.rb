class TrackFile < ApplicationRecord
  belongs_to :user
  belongs_to :event

  has_and_belongs_to_many :gpx_points
  has_one_attached :track

  validate :duplicate_track

  def duplicate_track
    errors.add(:track, 'already present') if track_present?
  end

  def track_present?
    TrackFile.find do |tr|
      tr.track.blob.byte_size == track.blob.byte_size &&
        tr.track.blob.filename == track.blob.filename
    end
  end
end
