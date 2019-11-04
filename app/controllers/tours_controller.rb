class ToursController < ApplicationController
  before_action :load_tour, only: :show

  def index
    @tours = Tour.paginate(page: params[:page],
      per_page: Settings.tours).order("created_at desc")
  end

  def show; end
end
