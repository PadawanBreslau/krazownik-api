class Challenge < ApplicationRecord
  default_scope { order('points ASC') }
  belongs_to :event
  has_many :challenge_completions, dependent: :destroy
  has_many :challenge_conditions, dependent: :destroy

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

  def completed
    false
  end
end
