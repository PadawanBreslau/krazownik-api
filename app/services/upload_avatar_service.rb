class UploadAvatarService
  include Base64FileUpload

  attr_reader :errors
  def initialize(user:, params:)
    @user = user
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
    update_file(@user, @params['file'], :avatar)
  end
end
