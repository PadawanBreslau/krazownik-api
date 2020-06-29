module Api
  module V1
    class ResultsController < Api::BaseController
      def index
        event = Event.recent

        if event
          event.participations.each(&:touch)
          results = event.participations.map(&:result)
          render json: ResultSerializer.new(results).serialized_json
        else
          render_error(status: :unprocessable_entity, title: 'Event not found')
        end
      end
    end
  end
end
