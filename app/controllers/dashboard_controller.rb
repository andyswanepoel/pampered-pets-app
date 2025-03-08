class DashboardController < ApplicationController
  def index
    @user = Current.user

    @pets = @user.pets.includes(:pettable)
  end
end
