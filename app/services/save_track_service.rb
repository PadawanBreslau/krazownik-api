class SaveTrackService
  def initialize(participation:, track:)
    @participation = participation
    @track = track
  end

  def call
    create_track
    save_averaged_points
  end

  private

  def create_track
    GpxTrack.create(total_ascent: @track.total_elevation_gain,
                    total_distance: @track.total_distance,
                    participation: @participation)
  end

  def save_averaged_points
    @track.averaged_points.each do |point|
      existing_point = find_nearby_averaged_point(point)
      existing_point.present? ? update_current_point(existing_point) : create_point(point)
    end
  end

  def find_nearby_averaged_point(point)
    GpxPoint.all.find { |saved_point| saved_point.close_enough?(point.first, point.last) }
  end

  def update_current_point(point)
    point.update(counter: point.counter + 1)
    @participation.gpx_points << point
  end

  def create_point(point)
    gpx_point = GpxPoint.create(lat: point.first, lng: point.last)
    @participation.gpx_points << gpx_point
  end
end
