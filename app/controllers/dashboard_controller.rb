class DashboardController < ApplicationController
  def index
    @user = Current.user

    @pets = @user.pets.includes(:pettable)
    @bookings = Booking.includes(:pet)
      .where(pet_id: @user.pets.select(:id))
      .group_by { |b| [ b.start_date, b.end_date, b.booking_status ] }
      .map do |(start_date, end_date, booking_status), bookings|
        { start_date: start_date, end_date: end_date, booking_status: booking_status, bookings: bookings }
      end
      .sort { |a, b| a[:start_date] <=> b[:start_date] }
  end
end
