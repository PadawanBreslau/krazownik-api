# frozen_string_literal: true

class User < ActiveRecord::Base
  extend Devise::Models

  has_one_attached :avatar
  has_many :photos, dependent: :nullify
  has_many :track_files, dependent: :nullify

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable
  include DeviseTokenAuth::Concerns::User

  has_many :participations, dependent: :destroy

  validates :name, presence: true
  validates :role, inclusion: { in: %w(user admin) }
  validates :birthyear, inclusion: { in: (1920..2030) },
                        unless: -> { birthyear.blank? }

  def belongs_to?(team)
    current_participation.in?(team.participations)
  end

  def allowed_to_contact?(different_user)
    admin? || self == different_user || same_team?(different_user)
  end

  def same_team?(different_user)
    current_participation.team == different_user.current_participation.team
  end

  def current_participation
    participations&.max_by { |p| p.event.year }
  end

  def admin?
    role == 'admin'
  end

  def age
    Date.today.year - birthyear
  end

  def unique_name
    name.split(' ').join('_').downcase.gsub('.', '') + id.to_s
  end
end
