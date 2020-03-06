class Spaceship < ApplicationRecord
  has_many :bookings, dependent: :destroy
  has_many :reviews, through: :bookings
  has_one_attached :photo
  belongs_to :user

  validates :name, :passengers, :length, :speed, :spaceship_class, :crew, :location, :manufacturer, :description, :price, presence: true
  validates :price, numericality: true

  def unavailable_dates
    bookings.pluck(:start_date, :end_date).map do |range|
      { from: range[0], to: range[1] }
    end
  end
  
end
