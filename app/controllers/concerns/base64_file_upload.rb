module Base64FileUpload
  extend ActiveSupport::Concern

  protected

  attr_reader :file_full_path

  def update_file(object, file_params, file)
    @user = object.is_a?(User) ? object : object.user
    @filename = save_file_on_server(file_params)
    @file_full_path = "#{Rails.root}/tmp/#{@filename}"

    if gpx?(@filename)
      @track_file = TrackFile.new(user: @user, event: Event.last)
      attach(@track_file, file)
      @track_file.save!
      ReadGpxPointsService.new(participation_id: @user.id,
                               track_file_id: @track_file.id,
                               filepath: @file_full_path).call
    end

    attach(object, file) if image?(@filename)
  ensure
    FileUtils.rm(file_full_path)
  end

  private

  def attach(object, file)
    object.send(file).attach(
      io: File.open(@file_full_path),
      filename: @filename
    )
  end

  def image?(filename)
    File.extname(filename).strip.downcase[1..-1].in? %w(png jpeg jpg)
  end

  def gpx?(filename)
    File.extname(filename).strip.downcase[1..-1] == 'gpx'
  end

  def save_file_on_server(file_params)
    service = SaveFilesOnServerService.new(file_params: file_params)
    service.call
    service.filename
  end
end
