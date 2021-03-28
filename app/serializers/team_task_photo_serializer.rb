class TeamTaskPhotoSerializer
  include FastJsonapi::ObjectSerializer
  include ImageHelper

  set_key_transform :underscore
  set_type :team_task_photo
  set_id :id

  attribute :approved_by_leader

  attribute :username do |object|
    object.user.name
  end

  attribute :created_at do |object|
    object.created_at.strftime("%R %F")
  end

  attribute :task_name do |object|
    object.team_task.content
  end

  attribute :leader do |object, params|
    params[:user].present? ? object.team_task.team.leader?(params[:user].current_participation) : false
  end

  attribute :photo do |object|
    image_path(object: object, image_field: :photo, resize: '360x360')
  end

  attribute :photo_small do |object|
    image_path(object: object, image_field: :photo, resize: '136x136')
  end
end
