class Event < ApplicationRecord
  has_many :challenges
  has_many :participations
  has_many :bonus_points
  has_many :riddles

  def self.recent
    where('? >  start_time', Time.current.to_date).order('start_time DESC').first
  end

  def photos
    participations.map(&:photos).flatten
  end

  alias_attribute :to_s, :year
end
