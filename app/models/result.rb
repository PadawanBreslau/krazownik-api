class Result < ApplicationRecord
  belongs_to :participation

  validates :participation_id, uniqueness: true
end
