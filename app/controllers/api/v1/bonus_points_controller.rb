module Api
  module V1
    class BonusPointsController < Api::BaseController
      def show
        bonus_point = BonusPoint.find_by(id: params[:id])
        authorize bonus_point

        bonus_point_formatted = BonusPointPresenter.new(bonus_point, user_context: current_api_v1_user)
        options = { include: [:bonus_point_completions, :participations] }

        render json: BonusPointSerializer.new(bonus_point_formatted, options).serialized_json
      end

      def index
        authorize BonusPoint

        year = SelectProperYearLogic.year
        event = Event.find_by(year: year)

        formatted_bonus_points = event.bonus_points&.includes([:image_attachment])&.map do |bp|
          BonusPointPresenter.new(bp, user_context: current_api_v1_user)
        end

        render json: BonusPointSerializer.new(formatted_bonus_points).serialized_json
      end

      def toggle
        bonus_point = BonusPoint.find(params[:id])
        authorize bonus_point

        service = ToggleBonusPointService.new(user: current_api_v1_user, bonus_point_id: params[:id].to_i)

        if service.call
          render json: BonusPointSerializer.new(
            BonusPointPresenter.new(service.bonus_point,
                                    user_context: current_api_v1_user)
          ).serialized_json
        else
          render_error(status: :unprocessable_entity, title: service.error)
        end
      end
    end
  end
end
