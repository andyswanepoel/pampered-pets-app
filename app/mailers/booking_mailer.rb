class BookingMailer < ApplicationMailer
  before_action :set_booking_info

  def pending_booking
    mail subject: "We've received your booking request!", to: @user.email_address
  end

  def accepted_booking
    mail subject: "Your booking has been accepted!", to: @user.email_address
  end

  def declined_booking
    mail subject: "We're sorry, your booking has been declined.", to: @user.email_address
  end

  def canceled_booking
    mail subject: "We're sorry, we've had to cancel your booking.", to: @user.email_address
  end

  private
  def set_booking_info
    @user = params[:user]
    @booking = params[:booking]
  end
end
