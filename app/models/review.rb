class Review < ApplicationRecord
  belongs_to :spaceship
  belongs_to :user
end
