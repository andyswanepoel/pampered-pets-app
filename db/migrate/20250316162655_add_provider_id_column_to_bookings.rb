class AddProviderIdColumnToBookings < ActiveRecord::Migration[8.0]
  def change
    add_reference :bookings, :provider, null: false, foreign_key: { to_table: :users }
  end
end
