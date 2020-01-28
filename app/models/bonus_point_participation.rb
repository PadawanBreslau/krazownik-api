class BonusPointParticipation < ApplicationRecord
  belongs_to :bonus_point
  belongs_to :participation

  validate :same_event

  def same_events
    errors.add(:participation, 'Not the same event') if bonus_point.event != participation.event
  end
end
