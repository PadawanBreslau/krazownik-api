class Participation < ApplicationRecord
  belongs_to :event
  belongs_to :user
  has_many :challenges_completions
  has_many :bonus_point_participations
  has_many :bonus_points, through: :bonus_point_participations

  validates :user, uniqueness: { scope: :event, message: 'Already participating' }
end
