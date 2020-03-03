class Spaceship < ApplicationRecord
  validates :name, :passengers, :length, :speed, :spaceship_class, :crew, :location, :manufacturer, :description, presence: true
  has_many :bookings
  has_many :reviews, through: :bookings
  belongs_to :user
end
