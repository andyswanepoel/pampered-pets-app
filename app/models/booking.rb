class Booking < ApplicationRecord
  belongs_to :pet
  before_create :set_pending
  before_update :set_pending

  enum :booking_status, [ :pending, :accepted, :declined ]

  def set_pending
    self.booking_status = :pending
  end
end
