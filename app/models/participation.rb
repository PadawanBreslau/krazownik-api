class Participation < ApplicationRecord
  belongs_to :event
  belongs_to :user
  has_many :challenge_completions
  has_many :challenges, through: :challenge_completions
  has_many :bonus_point_participations
  has_many :bonus_points, through: :bonus_point_participations

  has_many_attached :photos
  has_many_attached :track

  validates :user, uniqueness: { scope: :event, message: 'Already participating' }
end
