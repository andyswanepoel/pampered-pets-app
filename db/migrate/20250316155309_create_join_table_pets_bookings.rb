class CreateJoinTablePetsBookings < ActiveRecord::Migration[8.0]
  def change
    create_join_table :pets, :bookings do |t|
      t.index [ :pet_id, :booking_id ]
      t.index [ :booking_id, :pet_id ]
    end
  end
end
