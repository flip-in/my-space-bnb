class Spaceship < ApplicationRecord
  validates :name, :passengers, :length, :speed, :spaceship_class, :crew, :location, :manufacturer, :description, presence: true
  has_many :reviews
  belongs_to :user
end
