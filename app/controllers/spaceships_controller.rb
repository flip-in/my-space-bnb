class SpaceshipsController < ApplicationController
  def index
    @spaceships = policy_scope(Spaceship)
  end

  def show
    @spaceship = Spaceship.find(params[:id])
    authorize @spaceship
  end

  def new
    @spaceship = Spaceship.new
    authorize @spaceship
  end

  def create
    @spaceship = Spaceship.new(spaceship_params)
    authorize @spaceship
    @spaceship.user = current_user
      if @spaceship.save
        redirect_to spaceships_path
      else
        render :new
    end
  end

  def edit
    @spaceship = Spaceship.find(params[:id])
    authorize @spaceship
  end

  def update
    @spaceship = Spaceship.find(params[:id])
    authorize @spaceship
    @spaceship.update(spaceship_params)
    redirect_to dashboard_path
  end

  def destroy
    @spaceship = Spaceship.find(params[:id])
    authorize @spaceship
    @spaceship.destroy
    redirect_to spaceships_path
  end

private

  def spaceship_params
    params.require(:spaceship).permit(:name, :passengers, :length, :speed, :spaceship_class, :crew, :location, :manufacturer, :description, :price, :photo )
  end
end
