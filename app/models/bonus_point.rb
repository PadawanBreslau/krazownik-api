class BonusPoint < ApplicationRecord
  belongs_to :event
  has_many :bonus_point_completions
  has_many :participations, through: :bonus_point_completions

  has_one_attached :image

  def completed
    false
  end
end
