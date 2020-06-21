module Api
  module V1
    class ResultsController < Api::BaseController
      def index
        event = Event.recent
        results = event.participations.map(&:result)

        render json: RiddleSerializer.new(results).serialized_json
      end
    end
  end
end
