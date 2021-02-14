module Api
  module V1
    class RiddlesController < Api::BaseController
      def show
        riddle = Riddle.find_by(id: params[:id])
        authorize riddle

        render json: RiddleSerializer.new(riddle).serialized_json
      end

      def index
        authorize Riddle

        event = Event.last
        riddles = event.riddles.select(&:visible?)

        render json: RiddleSerializer.new(riddles).serialized_json
      end
    end
  end
end
