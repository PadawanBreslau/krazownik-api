module Api
  module V1
    module Crypto
      class ParticipationsController < Api::BaseController
        def show
          crypto_participation = CryptoParticipation.find_by(id: params[:id])
          authorize crypto_participation

          render json: CryptoParticipationSerializer.new(crypto_participation).serialized_json
        end

        def index
          authorize CryptoParticipation

          event = Event.last
          crypto_participations = event.crypto_participations

          render json: CryptoParticipationSerializer.new(crypto_participations).serialized_json
        end
      end
    end
  end
end
