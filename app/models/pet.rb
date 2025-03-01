class Pet < ApplicationRecord
  belongs_to :pettable, polymorphic: true
  belongs_to :user
  has_one_attached :image

  enum :sex, [ :male, :female ]
end
