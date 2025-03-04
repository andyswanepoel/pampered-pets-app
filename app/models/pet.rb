class Pet < ApplicationRecord
  belongs_to :pettable, polymorphic: true
  belongs_to :user
  has_one_attached :image do |attachable|
    attachable.variant :thumb, resize_to_limit: [ 100, 100 ]
  end

  enum :sex, [ :male, :female ]
end
