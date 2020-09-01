class UpdateTrackService
  def initialize(track:, params:)
    @track = track
    @params = params
  end

  def call
    update_params
  end

  private

  def update_params
    @track.update_attributes @params
  end
end
