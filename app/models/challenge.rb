class Challenge < ApplicationRecord
  belongs_to :event
  has_many :challenge_completions
  has_many :challenge_conditions

  has_one_attached :icon

  scope :current, ->(year) { joins(:event).where("events.year = #{year}") }
  scope :open, -> { where('open is true') }
  scope :hidden, -> { where('open is false') }
end
