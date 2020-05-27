class Participation < ApplicationRecord
  belongs_to :event
  belongs_to :user
  belongs_to :team, optional: true
  has_many :challenge_completions, dependent: :destroy
  has_many :challenges, through: :challenge_completions
  has_many :bonus_point_completions, dependent: :destroy
  has_many :bonus_points, through: :event
  has_many :gpx_tracks
  has_one :extra

  has_many_attached :photos
  has_many_attached :tracks

  validates :user, uniqueness: { scope: :event, message: 'Already participating' }
  delegate :name, to: :user

  def total_distance_points
    gpx_tracks.map { |track| track.total_distance * track.multiplier }.inject(:+).to_i
  end

  def total_ascent_points
    ((gpx_tracks.map { |track| track.total_ascent * track.multiplier }.inject(:+).to_f * 0.75) / 100.0).to_i
  end

  def files
    photos + tracks
  end
end
