class Riddle < ApplicationRecord
  default_scope { order('visible_from DESC') }
  belongs_to :event
end
