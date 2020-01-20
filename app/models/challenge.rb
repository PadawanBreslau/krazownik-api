class Challenge < ApplicationRecord
  belongs_to :event
  has_many :challenge_completions
  has_many :challenge_conditions
end
