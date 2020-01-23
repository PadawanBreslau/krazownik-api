class Riddle < ApplicationRecord
  default_scope { order('visible_from DESC') }
end
