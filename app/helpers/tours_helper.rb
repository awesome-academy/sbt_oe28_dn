module ToursHelper
  def full_title page_title
    base_title = I18n.t "base_title"
    return base_title if page_title.blank?

    page_title + " | " + base_title
  end

  def page_tour
    if params[:page].nil? || params[:page] == Settings.one
      0
    else
      page = params[:page].to_i - 1
      page * Settings.paginate.tours
    end
  end
end
