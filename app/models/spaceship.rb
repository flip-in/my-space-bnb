class Spaceship < ApplicationRecord
  has_many :bookings
  has_many :reviews
  belongs_to :user

  validates :name, :passengers, :length, :speed, :spaceship_class, :crew, :location, :manufacturer, :description, :price, presence: true
  validates :price, numericality: true

end
