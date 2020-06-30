# frozen_string_literal: true

class ApplicationMailer < ActionMailer::Base
  default from: ENV['MAIL_SMTP_FROM']

  layout 'mailer'
end
