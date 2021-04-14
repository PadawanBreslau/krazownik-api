module Api
  module V1
    class ResultsController < Api::BaseController
      def index
        authorize Result
        event = Event.recent

        if event
          participation_ids = event.participations.map(&:id)
          event.participations.includes([:user, :gpx_tracks, :challenges, :extra, :result]).each(&:touch)
          results = Result.where(participation_id: participation_ids).order('total DESC')
          render json: ResultSerializer.new(results).serialized_json
        else
          render_error(status: :unprocessable_entity, title: 'Event not found')
        end
      end
    end
  end
end
