module Api
  module V1
    module Crypto
      class RiddleSolutionsController < Api::BaseController
        before_action :authenticate_api_v1_user!

        def create
          authorize CryptoRiddleSolution
          service = CreateCryptoRiddleSolutionService.new(params: crypto_riddle_params, user: current_api_v1_user)

          if service.call
            render json: { status: service.status }
          else
            render_error(status: :unprocessable_entity, title: service.errors || 'Nie można było zapisać rozwiązania')
          end
        end

        private

        def crypto_riddle_params
          jsonapi_params.permit(:answer, :crypto_challenge_id, :crypto_participation_id)
        end
      end
    end
  end
end
