module Api
  module V1
    class PhotosController < Api::BaseController
      def show
        photo = Photo.find_by(id: params[:id])
        render json: PhotoSerializer.new(photo).serialized_json
      end

      def index
        @photos = if params[:user_id]
                    User.find(params[:user_id]).photos.map(&:photo_image)
                  else
                    ActiveStorage::Attachment.where(name: 'photo_image').take(10).shuffle
                  end
        render json: ImageSerializer.new(@photos).serialized_json
      end
    end
  end
end
