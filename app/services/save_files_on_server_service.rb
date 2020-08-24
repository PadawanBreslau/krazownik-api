class SaveFilesOnServerService
  MIME_TYPE_PREFIX = %r{(image|application)\/}.freeze
  DATA_MIME_TYPE_REMOVAL_REGEXP = /data:#{MIME_TYPE_PREFIX}.{3,},/.freeze
  EXTRACT_EXTENSION_REGEXP = %r{\b(?!.*\/).*}.freeze

  attr_reader :filename
  def initialize(file_params:)
    @file_params = file_params
  end

  def call
    content_type = @file_params[:content_type][EXTRACT_EXTENSION_REGEXP]
    @filename = @file_params[:filename] || 'file_' + Time.current.to_i + '.' + content_type
    contents = @file_params[:data].sub(DATA_MIME_TYPE_REMOVAL_REGEXP, '')

    decoded_data = Base64.decode64(contents)
    File.open("#{Rails.root}/tmp/#{filename}", 'wb') do |f|
      f.write(decoded_data)
    end
  end
end
