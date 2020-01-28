class Event < ApplicationRecord
  has_many :challenges
  has_many :participations
  has_many :bonus_points
end
