module Api
  module V1
    class RiddlesController < Api::BaseController
      def show
        riddle = Riddle.find_by(id: params[:id])

        render json: RiddleSerializer.new(riddle).serialized_json
      end

      def index
        riddles = Riddle.all.select(&:visible?)

        render json: RiddleSerializer.new(riddles).serialized_json
      end
    end
  end
end
