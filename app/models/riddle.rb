class Riddle < ApplicationRecord
  default_scope { order('visible_from ASC') }
  belongs_to :event

  def visible?
    visible_from - Time.current < 11.months && visible_from > Time.current - 1.month
  end
end
