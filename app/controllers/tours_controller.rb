class ToursController < ApplicationController
  before_action :load_tour, only: :show

  def index
    @tours = Tour.paginate(page: params[:page],
      per_page: Settings.tours).order("created_at desc")
  end

  def search
    @tours_search = Tour.search(params[:title]).paginate(page: params[:page],
      per_page: Settings.tours).order("created_at desc")
  end

  def show
    if @tour.ratings.blank?
      @average_rating = 0
    else
      @average_rating = @tour.ratings.average(:rating_value).round(2)
    end
  end
end
