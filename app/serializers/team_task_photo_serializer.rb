class TeamTaskPhotoSerializer
  include FastJsonapi::ObjectSerializer
  include ImageHelper

  set_key_transform :underscore
  set_type :team_task_photos
  set_id :id

  attribute :approved_by_leader4

  attribute :username do |object|
    object.user.name
  end

  attribute :photo do |object|
    image_path(object: object, image_field: :photo, resize: '360x360')
  end

  attribute :photo_small do |object|
    image_path(object: object, image_field: :photo, resize: '240x240')
  end
end
