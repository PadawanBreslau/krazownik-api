class Team < ApplicationRecord
  has_many :participations
  belongs_to :event
end
