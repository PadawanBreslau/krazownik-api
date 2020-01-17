class Challenge < ApplicationRecord
  belongs_to :event
  has_many :challenges_completions
end
