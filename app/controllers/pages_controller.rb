class PagesController < ApplicationController
  skip_before_action :authenticate_user!, raise: false
  def home
   
  end

  def dashboard
    @current_bookings = current_user.bookings.select { |booking| booking.end_date >= Date.today }
    @past_bookings = current_user.bookings.select { |booking| booking.end_date < Date.today }

  end
end
