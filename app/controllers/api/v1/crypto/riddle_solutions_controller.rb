module Api
  module V1
    module Crypto
      class RiddleSolutionsController < Api::BaseController
        before_action :authenticate_api_v1_user!

        def create
          authorize CryptoRiddleSolution

          if CryptoRiddleSolution.new(crypto_riddle_params).save
            render json: {}
          else
            render_error(status: :unprocessable_entity, title: 'Nie można było zapisać rozwiązania')
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
