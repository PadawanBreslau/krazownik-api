include ApplicationHelper

class Photo < ApplicationRecord
  belongs_to :user
  belongs_to :event
  has_one_attached :photo_image

  class << self
    if database_exists? && db_table_exists?('users') && db_table_exists?('photos')
      User.where(id: Photo.all.map(&:user_id))&.each do |u|
        define_method(u.unique_name) do
          Photo.all.select { |p| p.user_id = u.id }
        end
      end
    end
  end
end
