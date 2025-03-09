class DashboardController < ApplicationController
  def index
    @user = Current.user

    @pets = @user.pets.includes(:pettable)
    @bookings = Booking.where(pet_id: @user.pets.select(:id)).includes(:pet)
  end
end
