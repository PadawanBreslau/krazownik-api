class Event < ApplicationRecord
  has_many :challenges
  has_many :participations
  has_many :bonus_points
  has_many :riddles

  def photos
    participations.map(&:photos).flatten
  end
end
