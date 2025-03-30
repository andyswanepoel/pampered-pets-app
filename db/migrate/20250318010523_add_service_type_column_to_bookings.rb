class AddServiceTypeColumnToBookings < ActiveRecord::Migration[8.0]
  def change
    add_column :bookings, :service_type, :integer
  end
end
