# frozen_string_literal: true

class User < ActiveRecord::Base
  extend Devise::Models

  has_one_attached :avatar
  belongs_to :team, optional: true

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable
  include DeviseTokenAuth::Concerns::User

  has_many :participations, dependent: :destroy

  validates :name, presence: true

  def current_participation
    participations&.max_by { |p| p.event.year }
  end
end
