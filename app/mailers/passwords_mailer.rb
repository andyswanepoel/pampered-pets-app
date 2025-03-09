class PasswordsMailer < ApplicationMailer
  def reset
    @user = params[:user]
    mail subject: "Reset your password", to: @user.email_address
  end
end
