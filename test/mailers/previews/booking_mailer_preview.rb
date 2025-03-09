# Preview all emails at http://localhost:3000/rails/mailers/booking_mailer
class BookingMailerPreview < ActionMailer::Preview
  def pending_booking
    @user = User.take
    @pet_ids = @user.pets.pluck(:id)

    BookingMailer.with(user: @user, pet_ids: @pet_ids, start_date: Date.today, end_date: Date.today + 4).pending_booking
  end
end
