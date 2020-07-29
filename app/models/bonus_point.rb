class BonusPoint < ApplicationRecord
  default_scope { order('points ASC') }
  belongs_to :event
  has_many :bonus_point_completions, dependent: :destroy
  has_many :participations, through: :bonus_point_completions

  has_one_attached :image

  validate :point_already_near

  scope :following, -> { where(event_id: Event.following.id) }

  def completed
    false
  end

  def point_already_near
    errors.add(:lat, 'Point already defined in this area') if too_close?
  end

  private

  def too_close?
    BonusPoint.where(event_id: event_id).any? do |bp|
      Geokit::LatLng.new(lat, lng)
                    .distance_to("#{bp.lat}, #{bp.lng}") < 1.0
    end
  end
end
