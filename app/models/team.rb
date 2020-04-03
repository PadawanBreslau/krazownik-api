class Team < ApplicationRecord
  has_many :participations
  belongs_to :event

  has_one_attached :emblem
end
