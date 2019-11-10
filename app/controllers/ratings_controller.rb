class RatingsController < ApplicationController
  before_action :find_tour
  before_action :load_rating, only: %i(edit update destroy)

  def new
    @rating = Rating.new
  end

  def create
    @rating = Rating.new rating_params
    @rating.tour_id = @tour.id
    @rating.user_id = current_user.id

    if @rating.save
      redirect_to @tour
    else
      render :new
    end
  end

  def edit; end

  def update
    if @rating.update rating_params
      redirect_to @tour
    else
      render :edit
    end
  end

  def destroy
    @rating.destroy
    redirect_to @tour
  end

  private

  def rating_params
    params.require(:rating).permit :rating_value
  end

  def find_tour
    @tour = Tour.find_by params[:tour_id], params[:id]
  end

  def load_rating
    @rating = Rating.find_by id: params[:id]
  end
end
