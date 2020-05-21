module Base64FileUpload
  extend ActiveSupport::Concern

  protected

  def update_file(object, file_params, file)
    filename = save_file_on_server(file_params)
    file_full_path = "#{Rails.root}/tmp/#{filename}"
    save_track(object, file_full_path) if gpx?(filename)

    #   object.send(file).purge # Delete previous one
    object.send(file).attach(
      io: File.open(file_full_path),
      filename: filename
    )
  ensure
    FileUtils.rm(file_full_path)
  end

  MIME_TYPE_PREFIX = %r{(image|application)\/}.freeze
  VALID_FORMAT_REGEXP = /#{MIME_TYPE_PREFIX}[a-z]{3,}/.freeze
  def valid_format?(format)
    format.nil? || format.match?(VALID_FORMAT_REGEXP)
  end

  def gpx?(filename)
    File.extname(filename).strip.downcase[1..-1] == 'gpx'
  end

  def save_track(object, path)
    read_file = ReadGpx.new(file: path)
    read_file.read

    read_file.tracks.each do |track|
      SaveTrackService.new(participation: object, track: Track.new(track: track)).call
    end
  end

  # data removal of e.g. "data:application/pdf;base64,"
  DATA_MIME_TYPE_REMOVAL_REGEXP = /data:#{MIME_TYPE_PREFIX}.{3,},/.freeze
  EXTRACT_EXTENSION_REGEXP = %r{\b(?!.*\/).*}.freeze
  def save_file_on_server(file_params)
    content_type = file_params[:content_type][EXTRACT_EXTENSION_REGEXP]
    filename = file_params[:filename] || 'file_' + Time.current.to_i + '.' + content_type
    contents = file_params[:data].sub(DATA_MIME_TYPE_REMOVAL_REGEXP, '')

    decoded_data = Base64.decode64(contents)
    File.open("#{Rails.root}/tmp/#{filename}", 'wb') do |f|
      f.write(decoded_data)
    end
    filename
  end
end
