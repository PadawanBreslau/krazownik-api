module Api
  module V1
    module Crypto
      class ParticipationsController < Api::BaseController
        before_action :authenticate_api_v1_user!, only: [:show]

        def show
          crypto_participation = CryptoParticipation.find_by(id: params[:id])
          authorize crypto_participation

          render json: CryptoParticipationSerializer.new(crypto_participation).serialized_json
        end

        def index
          crypto_participations = Event.last&.crypto_participations&.includes([:participation])

          if crypto_participations
            result = crypto_participations.left_joins(:crypto_riddle_solutions)
                                          .where('crypto_riddle_solutions.status is true')
                                          .group(:id).order('count(crypto_riddle_solutions.id) DESC')

            render json: CryptoParticipationSerializer.new(result,
                                                           params: { basic: true,
                                                                     user: current_api_v1_user }).serialized_json
          else
            render json: {}
          end
        end

        def own
          event = Event.current
          crypto_participation = CryptoParticipation.joins(:participation)
                                                    .where('participations.event_id = ? AND participations.user_id = ?',
                                                           event.id, current_api_v1_user.id)
          authorize crypto_participation

          render json: CryptoParticipationSerializer.new(crypto_participation).serialized_json
        end
      end
    end
  end
end
