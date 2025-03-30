class DashboardController < ApplicationController
  before_action :set_user, :set_bookings, :set_pets
  def index
    if is_provider?
      render :provider_dashboard
    else
      render :customer_dashboard
    end
  end

  def customer_dashboard
    @pets = @user.pets
    @bookings = @user.bookings.includes(:pets).order(:start_date)
  end

  def provider_dashboard
  end

  private
  def set_user
    @user = Current.user
  end
  def set_bookings
    if is_provider?
    @bookings = Booking.where(provider_id: @user.id)
    else
    @bookings = @user.bookings.includes(:pets).order(:start_date)
    end
  end
  def set_pets
    @pets = @user.pets if !is_provider?
  end
end
