class DashboardController < ApplicationController
  before_action :set_user, :set_bookings, :set_pets
  def index
    redirect_to new_pet_path, notice: "Please add your first pet!" if is_customer? and @pets.length == 0
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
