class BookingsController < ApplicationController
  def new
    @booking = Booking.new
    @spaceship = Spaceship.find(params[:spaceship_id])
    authorize @booking
  end

  def create
    @booking = Booking.new(booking_params)
    authorize @booking
    @booking.user = current_user
    @booking.spaceship = Spaceship.find(params[:spaceship_id])
      if @booking.save
        redirect_to dashboard_path
      else
        render :new
      end
  end

  def show
  end

  def booking_params
    params.require(:booking).permit(:start_date, :end_date)
  end
end
