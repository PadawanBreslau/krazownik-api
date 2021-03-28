module Api
  module V1
    class TeamTaskPhotosController < Api::BaseController
      def show
        photo = TeamTaskPhoto.find(params['id'])

        authorize photo

        options = {
          params: { user: current_api_v1_user }
        }
        render json: TeamTaskPhotoSerializer.new(photo, options)
      end

      def update
        photo = TeamTaskPhoto.find(params['id'])
        authorize photo

        photo.update(approved_by_leader: photo_params['approved_by_leader'])

        options = {
          params: { user: current_api_v1_user }
        }
        render json: TeamTaskPhotoSerializer.new(photo, options)
      end

      def destroy
        photo = TeamTaskPhoto.find(params['id'])

        authorize photo

        photo.destroy!

        render_success
      end

      def photo_params
        jsonapi_params.permit('approved_by_leader')
      end
    end
  end
end
