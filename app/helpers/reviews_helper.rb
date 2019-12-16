module ReviewsHelper
  def page_review
    if params[:page].nil? || params[:page] == Settings.one
      0
    else
      page = params[:page].to_i - 1
      page * Settings.paginate.reviews
    end
  end
end
