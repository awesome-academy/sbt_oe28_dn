class RatingsController < ApplicationController
  before_action :find_tour, :logged_in_user

  def create
    @rating = Rating.new rating_params
    @rating.tour_id = @tour.id
    @rating.user_id = current_user.id

    if @rating.save
      flash[:success] = t "msg.rating_succeeded"
    else
      flash[:info] = t "msg.rating_failed"
    end
    redirect_to @tour
  end

  private

  def rating_params
    params.require(:rating).permit :rating_value
  end

  def find_tour
    @tour = Tour.find_by id: params[:tour_id]
    return if @tour

    flash[:danger] = t "msg.tour_inv"
    redirect_to tours_path
  end
end
