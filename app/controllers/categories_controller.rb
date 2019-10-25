class CategoriesController < ApplicationController
  def show
    @title = returntitle params[:id_category]
    @reviews = Review.load_review(params[:id_category])
                     .newest
                     .paginate page: params[:page], per_page: Settings.review
  end

  private

  def returntitle id
    case id
    when Settings.newsId
      t "nav.news"
    when Settings.foodId
      t "nav.food"
    when Settings.placeId
      t "nav.place"
    else
      redirect_to root_path
    end
  end
end
