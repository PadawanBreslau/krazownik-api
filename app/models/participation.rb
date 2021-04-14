class Participation < ApplicationRecord
  belongs_to :event
  belongs_to :user
  belongs_to :team, optional: true
  has_many :challenge_completions, dependent: :destroy
  has_many :challenges, through: :challenge_completions
  has_many :bonus_point_completions, dependent: :destroy
  has_many :bonus_points, through: :event
  has_many :gpx_tracks, dependent: :destroy
  has_and_belongs_to_many :gpx_points
  has_one :extra, dependent: :destroy
  has_one :result, dependent: :destroy
  has_one :crypto_participation

  has_many_attached :photos
  has_many_attached :tracks

  validates :user, uniqueness: { scope: :event, message: 'Already participating' }
  delegate :name, to: :user
  delegate :year, to: :event

  after_commit :create_or_update_results

  scope :current, -> { where(event_id: Event.last.id) }

  def create_or_update_results
    logic = ResultCalculator.new(participation: self)

    return unless logic.call

    result&.destroy
    CreateResultService.new(participation: self, result: logic.result, total: logic.total).call
  end

  def total_distance_points
    track_files.map { |track| track.distance * track.multiplier }.inject(:+).to_i
  end

  def total_ascent_points
    ((track_files.map { |track| track.ascent * track.multiplier }.inject(:+).to_f * 1.5) / 100.0).to_i
  end

  def track_files
    TrackFile.where(user: user, event: event)
  end

  def files
    photos + tracks
  end
end
