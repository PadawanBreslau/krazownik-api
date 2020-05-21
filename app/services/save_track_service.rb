class SaveTrackService
  def initialize(participation:, track:)
    @participation = participation
    @track = track
  end

  def call
    create_track
  end

  private

  def create_track
    GpxTrack.create(total_ascent: @track.total_elevation_gain,
                    total_distance: @track.total_distance,
                    participation: @participation)
  end
end
