class UsersController < ApplicationController
  allow_unauthenticated_access

  def new
    @user = User.new
  end

  def create
    @user = User.new(**user_params, tenant: tenant)

    if @user.save
       VerificationMailer.with(user: @user).verify_email.deliver_later
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
