class Team < ApplicationRecord
  has_many :participations, -> { where team_ready: true }, dependent: :nullify
  belongs_to :event

  has_one_attached :emblem
end
