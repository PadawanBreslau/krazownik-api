class TeamTask < ApplicationRecord
  belongs_to :team

  has_many_attached :photos
end
