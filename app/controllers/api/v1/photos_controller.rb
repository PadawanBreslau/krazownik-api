module Api
  module V1
    class PhotosController < Api::BaseController
      def index
        @photos = ActiveStorage::Attachment.where(name: 'photos').select{|att| att.blob.byte_size < 1048576}.shuffle

        render json: PhotoSerializer.new(@photos).serialized_json
      end
    end
  end
end
