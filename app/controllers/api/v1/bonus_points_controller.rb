module Api
  module V1
    class BonusPointsController < Api::BaseController
      def show
        bonus_point = BonusPoint.find_by(id: params[:id])

        render json: BonusPointSerializer.new(bonus_point).serialized_json
      end

      def index
        year = SelectProperYearLogic.new.call
        event = Event.find_by(year: year)

        render json: BonusPointSerializer.new(event.bonus_points).serialized_json
      end
    end
  end
end
