class PagesController < ApplicationController
  skip_before_action :authenticate_user!, raise: false
  def home
    @spaceships = Spaceship.all
    @spaceships = @spaceships.sample(3)
  end

  def dashboard
    @current_bookings = current_user.bookings.select { |booking| booking.end_date >= Date.today && (booking.status == 'pending' || booking.status == 'confirmed') }
    @past_bookings = current_user.bookings.select { |booking| booking.end_date < Date.today && (booking.status == 'pending' || booking.status == 'confirmed') }

  end
end
