class AddStatusToBooking < ActiveRecord::Migration[8.0]
  def change
    add_column :bookings, :booking_status, :integer
  end
end
