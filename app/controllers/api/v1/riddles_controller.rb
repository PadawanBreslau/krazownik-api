module Api
  module V1
    class RiddlesController < Api::BaseController
      def show
        challenge = Riddle.find_by(id: params[:id])

        render json: RiddleSerializer.new(challenge).serialized_json
      end

      def index
        riddles = Riddle.all.select { |r| r.visible_from - Time.current < 11.months }

        render json: RiddleSerializer.new(riddles).serialized_json
      end
    end
  end
end
