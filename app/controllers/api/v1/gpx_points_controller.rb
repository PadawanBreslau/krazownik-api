module Api
  module V1
    class GpxPointsController < Api::BaseController
      def index
        authorize GpxPoint

        event = Event.last # .find_by(year: year)

        gpx_points = event.track_files.where(event_id: event.id).map(&:gpx_points).flatten.uniq

        render json: GpxPointSerializer.new(gpx_points).serialized_json
      end
    end
  end
end
