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
    @booking = Booking.find(params[:id])
    authorize @booking
  end

  def accept
    @booking = Booking.find(params[:id])
    authorize @booking
    @booking.status = 'confirmed'
    @booking.save
    redirect_to dashboard_path
  end

  def reject
    @booking = Booking.find(params[:id])
    authorize @booking
    @booking.status = 'rejected'
    @booking.save
    redirect_to dashboard_path
  end

  def pending
    @booking = Booking.find(params[:id])
    authorize @booking
    @booking.status = 'pending'
    @booking.save
    redirect_to dashboard_path
  end

  def cancel
    @booking = Booking.find(params[:id])
    authorize @booking
    @booking.status = 'canceled'
    @booking.save
    redirect_to dashboard_path
  end

  def booking_params
    params.require(:booking).permit(:start_date, :end_date)
  end
end
