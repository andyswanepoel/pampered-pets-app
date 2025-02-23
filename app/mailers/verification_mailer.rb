class VerificationMailer < ApplicationMailer
  def verify_email(user)
    @user = user
    @verification_url = verify_account_url(token: user.generate_verification_token)

    mail(to: @user.email_address, subject: "Verify your account")
  end
end
