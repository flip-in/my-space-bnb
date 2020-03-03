class SpaceshipsController < ApplicationController
  def index
    @spaceships = Spaceship.all
  end

  def show
    @spaceship = Spaceship.find(params[:id])
  end

  def new
    @spaceship = Spaceship.new
  end

  def create
    @spaceship = Spaceship.new(spaceship_params)
    @spaceship.user = current_user
      if @spaceship.save
        redirect_to spaceships_path
      else
        render :new
    end
  end

  def edit
    @spaceship = Spaceship.find(params[:id])
  end

  def update
    @spaceship = Spaceship.find(params[:id])
    @spaceship.update(spaceship_params)
    redirect_to spaceships_path(@spaceship.id)
  end

  def destroy
    @spaceship = Spaceship.find(params[:id])
    @spaceship.destroy
    redirect_to spaceships_path
  end

private

  def spaceship_params
    params.require(:spaceship).permit(:name, :passengers, :length, :speed, :spaceship_class, :crew, :location, :manufacturer, :description, :price )
  end
end
