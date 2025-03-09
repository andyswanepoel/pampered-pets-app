class ApplicationMailer < ActionMailer::Base
  default from: email_address_with_name("notification@pamperedpetsapp.com", "Pampered Pets App")
  layout "mailer"
  helper :mailer
end
