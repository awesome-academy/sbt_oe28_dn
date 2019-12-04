class ToursController < ApplicationController
  before_action :load_tour, only: :show

  def index
    @search = Tour.ransack(params[:q])
    @tours = @search.result.newest.paginate(page: params[:page],
      per_page: Settings.paginate.tours)
  end

  def show
    if logged_in?
      @rating_check_exist = Rating.check_rating(current_user.id,
        params[:id])
    end
    @average_rating = Settings.zero
    return if @tour.ratings.blank?

    @average_rating = @tour.ratings.average(:rating_value).round(Settings.two)
  end

  private

  def load_tour
    @tour = Tour.find_by id: params[:id]
    return if @tour

    flash[:danger] = t "msg.tour_inv"
    redirect_to tours_path
  end
end
