class PagesController < ApplicationController
  def home
  end

  def dashboard
    @current_bookings = current_user.bookings.select { |booking| booking.end_date >= Date.today }
    @past_bookings = current_user.bookings.select { |booking| booking.end_date < Date.today }

  end
end
