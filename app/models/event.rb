class Event < ApplicationRecord
  has_many :challenges
  has_many :participations
  has_many :bonus_points
  has_many :riddles

  #  scope :recent, -> { where('? >  start_time', Time.current.to_date).order('start_time DESC') }

  def photos
    participations.map(&:photos).flatten
  end

  def self.recent
    where('? >  start_time', Time.current.to_date).order('start_time DESC').first
  end
end
