class UploadTaskPhotoService
  include Base64FileUpload

  attr_reader :errors
  def initialize(user:, task:, params:)
    @user = user
    @task = task
    @params = params
  end

  def call
    check_extension
    return false unless @picture

    upload_picture
    true
  rescue ActiveRecord::RecordInvalid => e
    @errors = e.message
    false
  end

  private

  def check_extension
    content_type = @params.dig('file', 'content_type')
    @picture = true if content_type.in? ['image/png', 'image/jpeg']
  end

  def upload_picture
    team_photo = @task.team_task_photos.create(user: @user)
    update_file(team_photo, @params['file'], :photo)
  end
end
