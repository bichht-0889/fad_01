class ApplicationMailer < ActionMailer::Base
  default from: Settings.app.mailers.application.email
  layout "mailer"
end
