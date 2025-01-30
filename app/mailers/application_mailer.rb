class ApplicationMailer < ActionMailer::Base
  default from: Rails.application.credentials.email_address
  layout "mailer"
end
