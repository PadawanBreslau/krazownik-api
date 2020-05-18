class BonusPoint < ApplicationRecord
  default_scope { order('points ASC') }
  belongs_to :event
  has_many :bonus_point_completions, dependent: :destroy
  has_many :participations, through: :bonus_point_completions

  has_one_attached :image

  def completed
    false
  end
end
