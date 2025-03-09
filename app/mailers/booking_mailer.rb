class BookingMailer < ApplicationMailer
  def pending_booking
    @user = params[:user]
    @pets = Pet.where(id: params[:pet_ids])
    @start_date = Date.parse params[:start_date]
    @end_date = Date.parse params[:end_date]
    mail subject: "We've received your booking request!", to: @user.email_address
  end

  def approved_booking
  end
end
