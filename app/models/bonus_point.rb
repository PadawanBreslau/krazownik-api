class BonusPoint < ApplicationRecord
  belongs_to :event
  has_many :bonus_point_participations
  has_many :participations, through: :bonus_point_participations

  has_one_attached :map_image
end
