class TrackFile < ApplicationRecord
  belongs_to :user
  belongs_to :event
  has_and_belongs_to_many :gpx_points
  has_one_attached :track

  validate :duplicate_track, on: :create
  delegate :year, to: :event

  before_destroy :delete_ununified_gpx_points

  store :metadata, accessors: [:distance, :ascent, :descent, :total_time, :start_time, :start_date]

  def delete_ununified_gpx_points; end

  def filename
    track&.blob&.filename&.to_s
  end

  def byte_size
    track&.blob&.byte_size
  end

  def duplicate_track
    errors.add(:track, 'already present') if track_present?
  end

  def points
    return 0.0 if distance.nil? && ascent.nil?

    (points_from_distance + points_from_ascent) * multiplier
  end

  def points_from_distance
    distance.floor
  end

  ASCENT_MULTIPLIER = 1.5
  def points_from_ascent
    (ascent / 100) * ASCENT_MULTIPLIER
  end

  def track_present?
    TrackFile.find do |tr|
      tr.byte_size == byte_size &&
        tr.filename == filename
    end
  end
end
