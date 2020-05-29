module Api
  module V1
    class GpxPointsController < Api::BaseController
      def index
        year = SelectProperYearLogic.year
        event = Event.find_by(year: year)

        gpx_points = event.participations.map(&:gpx_points).flatten.uniq

        render json: GpxPointSerializer.new(gpx_points).serialized_json
      end
    end
  end
end
