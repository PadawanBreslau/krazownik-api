class Participation < ApplicationRecord
  belongs_to :event
  belongs_to :user
  belongs_to :team, optional: true
  has_many :challenge_completions, dependent: :destroy
  has_many :challenges, through: :challenge_completions
  has_many :bonus_point_completions, dependent: :destroy
  has_many :bonus_points, through: :event
  has_one :extra

  has_many_attached :photos
  has_many_attached :tracks

  validates :user, uniqueness: { scope: :event, message: 'Already participating' }
  delegate :name, to: :user

  def files
    photos + tracks
  end
end
