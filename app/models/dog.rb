class Dog < ApplicationRecord
  enum :activity_level, [ :low, :medium, :high ]
end
