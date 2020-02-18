class Challenge < ApplicationRecord
  belongs_to :event
  has_many :challenge_completions
  has_many :challenge_conditions

  has_one_attached :icon

  before_save :attach_default_icon

  scope :current, ->(year) { joins(:event).where("events.year = #{year}") }
  scope :open, -> { where('open is true') }
  scope :hidden, -> { where('open is false') }

  def attach_default_icon
    return if icon.attached?

    icon.attach(io: File.open(Rails.root.join('app', 'assets', 'images', 'question.png')),
                filename: 'question.png', content_type: 'image/png')
  end
end
