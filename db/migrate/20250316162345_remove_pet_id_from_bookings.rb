class RemovePetIdFromBookings < ActiveRecord::Migration[8.0]
  def change
    remove_column :bookings, :pet_id, :integer
  end
end
