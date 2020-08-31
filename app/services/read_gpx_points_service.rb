require 'simple_trail'

class ReadGpxPointsService
  def initialize(participation_id:, track_file_id:, filepath:)
    @participation_id = participation_id
    @track_file_id = track_file_id
    @filepath = filepath
  end

  def call
    read_file
    manipulate_data
    store_all_point_data

    true
  rescue StandardError => e
    raise "Something happened during gpx file parse: #{e}"
  end

  def read_file
    @parser = Parser::Gpx.new(@filepath)
    @parser.read
    @points = @parser.points
  end

  def manipulate_data
    # straightener = Manipulation::Straightener.new(@points)
    # straightener.points_without_clusters
    # @straigh_points = straightener.points
    @statistics = Manipulation::Statistics.new(@points).basic_statistics
  end

  def store_all_point_data
    track_file = TrackFile.find(@track_file_id)
    metadata = { distance: @statistics[:distance].round(3),
                 ascent: @statistics[:ascent], descent: @statistics[:descent] }
    track_file.update(metadata: metadata)

    @points.each_with_index do |point, i|
      gpx_point = GpxPoint.create(lat: point[:lat], lon: point[:lon], unified: false, counter: 1, track_index: i)
      track_file.gpx_points << gpx_point
    end
  end
end
