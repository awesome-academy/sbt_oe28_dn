class ToursController < ApplicationController
  before_action :load_tour, only: :show

  def index
    @tours = Tour.newest.paginate(page: params[:page],
      per_page: Settings.paginate.tours)
  end

  def search
    @tours_search = Tour.search(params[:title]).newest.paginate(
      page: params[:page], per_page: Settings.paginate.tours
    )
  end

  def show
    if logged_in?
      @rating_check_exist = Rating.check_rating(current_user.id,
        params[:id])
    end
    @average_rating = 0
    return if @tour.ratings.blank?
    @average_rating = @tour.ratings.average(:rating_value).round(2)
  end

  private

  def load_tour
    @tour = Tour.find_by id: params[:id]
    return if @tour

    flash[:danger] = t "msg.tour_inv"
    redirect_to tours_path
  end
end
