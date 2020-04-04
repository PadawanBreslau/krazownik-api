module Api
  module V1
    class BonusPointsController < Api::BaseController
      def show
        bonus_point = BonusPoint.find_by(id: params[:id])

        render json: BonusPointSerializer.new(bonus_point).serialized_json
      end

      def index
        year = SelectProperYearLogic.year
        event = Event.find_by(year: year)

        render json: BonusPointSerializer.new(event.bonus_points).serialized_json
      end

      def toggle
        authorize BonusPoint

        service = ToggleBonusPointService.new(user: current_api_v1_user, bonus_point_id: params[:id].to_i)

        if service.call
          render json: BonusPointSerializer.new(service.bonus_point).serialized_json
        else
          render_error(status: :unprocessable_entity, title: service.error)
        end
      end
    end
  end
end
