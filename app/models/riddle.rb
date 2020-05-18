class Riddle < ApplicationRecord
  default_scope { order('visible_from ASC') }
  belongs_to :event
end
