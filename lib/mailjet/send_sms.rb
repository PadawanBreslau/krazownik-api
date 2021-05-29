module Mailjet
  class SendSms
    MAILJET_URL = 'https://api.mailjet.com/v4/sms-send'.freeze
    def initialize(phone:, content:)
      @phone = phone
      @content = content
    end

    def send
      return if Rails.env.test?

      uri = URI.parse(MAILJET_URL)
      request = Net::HTTP::Post.new(uri)
      request.content_type = 'application/json'
      request['Authorization'] = "Bearer #{ENV['SMS_TOKEN']}"
      request.body = JSON.dump(
        'From' => 'Krazownik',
        'To' => @phone,
        'Text' => @content
      )

      req_options = {
        use_ssl: uri.scheme == 'https'
      }

      response = Net::HTTP.start(uri.hostname, uri.port, req_options) do |http|
        http.request(request)
      end

      response.code == 200
    end
  end
end
