class VerificationController < ApplicationController
  skip_before_action :require_authentication
  before_action :set_user_by_token, only: %i[ verify_account ]

  def index
  end

  def verify_account
    if @user
      @user.update(account_verified: true)
      start_new_session_for @user
      redirect_to root_path, notice: "Your account has been verified!"
    else
      redirect_to root_path, alert: "Invalid or expired verification link."
    end
  end

  def send_verification_email
    if user = User.find_by(email_address: params[:email_address])
      VerificationMailer.verify_email(user).deliver_later
    end
    redirect_to send_verification_path, notice: "Check your email to verify your account."
  end


  private

  def set_user_by_token
    @user = User.find_signed!(params[:token], purpose: "email_verification")
  rescue ActiveSupport::MessageVerifier::InvalidSignature
    redirect_to new_password_path, alert: "Password reset link is invalid or has expired."
  end
end
