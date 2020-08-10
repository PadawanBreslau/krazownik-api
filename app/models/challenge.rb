class Challenge < ApplicationRecord
  belongs_to :event
  has_many :challenge_completions, dependent: :destroy
  has_many :challenge_conditions, dependent: :destroy
  has_one_attached :icon

  before_save :attach_default_icon
  before_save :validate_details, if: :will_save_change_to_details?

  default_scope { order('points ASC') }
  scope :following, -> { where(event_id: Event.following.id) }
  scope :current, ->(year) { joins(:event).where("events.year = #{year}") }
  scope :open, -> { where("open is true AND event_id = #{Event.following.id}") }
  scope :hidden, -> { where("open is false AND event_id = #{Event.following.id}") }

  store :details, accessors: [:locations]

  def attach_default_icon
    return if icon.attached?

    icon.attach(io: File.open(Rails.root.join('app', 'assets', 'images', 'question.png')),
                filename: 'question.png', content_type: 'image/png')
  end

  def completed
    false
  end

  def validate_details
    return unless locations
    raise ActiveRecord::RecordInvalid.new unless proper_details?
  end

  def proper_details?
    locations.is_a?(Array) && locations.all? do |location|
      location.keys.sort == %w(lat lon) && location.values.none?(:nil?)
    end
  end
end
