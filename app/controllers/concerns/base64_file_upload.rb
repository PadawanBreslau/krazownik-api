module Base64FileUpload
  extend ActiveSupport::Concern

  protected

  def update_file(object, file_params, file)
    @user = object.user
    filename = save_file_on_server(file_params)
    file_full_path = "#{Rails.root}/tmp/#{filename}"

    if gpx?(filename)
      @track_file = TrackFile.new(user: @user, event: Event.last)
      @track_file.send(file).attach(
        io: File.open(file_full_path),
        filename: filename
      )
      @track_file.save!
    end

    ReadGpxPointsService.new(participation_id: object.id, track_file_id: @track_file.id, filepath: file_full_path).call
  ensure
    FileUtils.rm(file_full_path)
  end

  private

  def gpx?(filename)
    File.extname(filename).strip.downcase[1..-1] == 'gpx'
  end

  def save_file_on_server(file_params)
    service = SaveFilesOnServerService.new(file_params: file_params)
    service.call
    service.filename
  end
end
