class ReviewsController < ApplicationController
  def new
    @review = Review.new
    @booking = Booking.find(params[:booking_id])
    authorize @review
  end

  def create
    @booking = Booking.find(params[:booking_id])
    @review = Review.new(review_params)
    @review.user = current_user
    @review.booking = @booking
    authorize @review
    if @review.save
      redirect_to dashboard_path
    else
      flash[:alert] = 'Something went wrong.'
      render :new
    end
  end

  private

  def review_params
    params.require(:review).permit(:content, :stars)
  end

end
