class Event < ApplicationRecord
  has_many :challenges
  has_many :participations
  has_many :crypto_participations, through: :participations
  has_many :bonus_points
  has_many :riddles
  has_many :track_files
  has_many :teams
  has_one :crypto_challenge

  validates :start_time, presence: true

  store :informations, accessors: [:date, :place, :phone, :base_location, :base_address, :lat, :lon, :url,
                                   :regulations_url, :fb_event_url]

  def self.current
    where(year: Time.current.year).first
  end

  def self.recent
    where('? >  start_time', Time.current.to_date).order('start_time DESC').first
  end

  def self.following
    where('? <  start_time', Time.current.to_date).order('start_time DESC').first
  end

  def photos
    participations.map(&:photos).flatten
  end

  def started?
    start_time && start_time < Time.current
  end

  def accomodation_coords
    [lat.to_f, lon.to_f]
  end

  alias_attribute :to_s, :year
end
