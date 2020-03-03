class ReviewsController < ApplicationController
  def new
    @review = Review.new
    @spaceship = Spaceship.find(params[:spaceship_id])
    authorize @review
  end

  def create
    @spaceship = Spaceship.find(params[:spaceship_id])
    @review = Review.new(review_params)
    @review.user = current_user
    @review.spaceship = @spaceship
    authorize @review

    if @review.save
      redirect_to spaceship_path(@spaceship)
    else
      flash[:alert] = "Something went wrong."
      render :new
    end
  end
  private

  def review_params
    params.require(:review).permit(:content, :stars)
  end
end
