class Booking < ApplicationRecord
  has_and_belongs_to_many :pets
  belongs_to :provider, class_name: "User"
  belongs_to :user
  before_create :set_pending
  before_update :set_pending

  enum :booking_status, [ :pending, :accepted, :declined ]
  enum :service_type, [ :boarding, :daycare ]

  def set_pending
    self.booking_status = :pending
  end
end
