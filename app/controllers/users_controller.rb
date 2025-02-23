class UsersController < ApplicationController
  skip_before_action :require_authentication, only: %i[ new create ]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
       VerificationMailer.verify_email(@user).deliver_later
      redirect_to login_path, notice: "Check your email to verify your account."
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email_address, :password, :password_confirmation)
  end
end
