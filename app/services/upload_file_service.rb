class UploadFileService
  include Base64FileUpload

  def initialize(user: , params:)
    @user = user
    @params = params
  end

  def call
    check_extension
    find_current_participation

    return if @participation.blank?

    if @picture
      upload_picture
    elsif @gpx
      upload_track
    else
      false
    end
  end

  private

  def check_extension
    content_type = @params.dig("file", "content_type")
    @picture = true if  content_type == 'image/png' || content_type == 'image/jpeg'
    @gpx = true if  content_type == "application/gpx+xml"
  end

  def find_current_participation
    @participation = @user.current_participation
  end

  def upload_picture
    update_file(@participation, @params['file'], :photos)
  end

  def upload_track
    update_file(@participation, @params['file'], :tracks)
  end
end
