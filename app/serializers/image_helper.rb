module ImageHelper
  extend ActiveSupport::Concern
  include Rails.application.routes.url_helpers

  class_methods do
    def image_path(object:, image_field:, resize: '100x100')
      if object.public_send(image_field)&.attached?
        require 'pry'; binding.pry
        ENV['BACKEND_APP_URL'] + Rails.application.routes.url_helpers
                                      .rails_representation_url(
                                        object.public_send(image_field).variant(resize: resize).processed,
                                        only_path: true
                                      )

      end
    end
  end
end
