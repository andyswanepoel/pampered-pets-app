class Cat < ApplicationRecord
  enum :environment, [ :indoor, :outdoor, :indoor_outdoor ]
end
