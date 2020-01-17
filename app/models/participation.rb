class Participation < ApplicationRecord
  belongs_to :event
  belongs_to :user
  has_many :challenges_completions

  validates :user, uniqueness: { scope: :event, message: 'Already participating' }
end
