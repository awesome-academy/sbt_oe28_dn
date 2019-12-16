class RatingsController < ApplicationController
  before_action :load_tour, :authenticate_user!

  def create
    @rating = current_user.ratings.build rating_params
    @rating.tour_id = @tour.id

    if @rating.save
      flash[:success] = t "msg.rating_succeeded"
    else
      flash[:info] = t "msg.rating_failed"
    end
    redirect_to @tour
  end

  private

  def rating_params
    params.require(:rating).permit Rating::UPDATE_ATTRS
  end

  def load_tour
    @tour = Tour.find_by id: params[:tour_id].to_i
    return if @tour

    flash[:danger] = t "msg.tour_inv"
    redirect_to tours_path
  end
end
