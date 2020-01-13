class Event < ApplicationRecord
  has_many :challenges
  has_many :participations
end
