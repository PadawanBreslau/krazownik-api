class Participation < ApplicationRecord
  belongs_to :event
  belongs_to :user

  validates :user, uniqueness: {scope: :event, message: 'Already participating'}
end
