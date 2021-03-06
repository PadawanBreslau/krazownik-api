module Api
  module V1
    class ParticipationsController < Api::BaseController
      def show
        participation = Participation.find_by(id: params[:id])
        authorize participation

        if participation.user == current_api_v1_user
          options = { include: [:gpx_points, :extra, :teams,
                                :challenges, :challenge_completions, :bonus_points, :bonus_point_completions] }
          render json: ParticipationSerializer.new(participation, options).serialized_json
        end
      end

      def index
        authorize Participation
        participations = current_api_v1_user.participations
                                            .includes([:event, :gpx_tracks, :extra])
        render json: ParticipationSerializer.new(participations).serialized_json
      end

      def current
        authorize Participation
        participation_users = Event.last.participations.map(&:user)
        render json: UserSerializer.new(participation_users).serialized_json
      end

      def create
        authorize Participation
        participation_service = CreateParticipationService.new(user: current_api_v1_user)

        if participation_service.call
          options = { include: [:challenges, :challenge_completions] }
          render json: ParticipationSerializer.new(participation_service.participation, options).serialized_json
        else
          render_error(status: :unprocessable_entity, title: participation_service.error)
        end
      end
    end
  end
end
