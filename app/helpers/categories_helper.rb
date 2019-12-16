module CategoriesHelper
  def cate_select
    @categories.map{|cate| [t("nav.#{cate.name}"), cate.id]}
  end

  def page_cate
    if params[:page].nil? || params[:page] == Settings.one
      0
    else
      page = params[:page].to_i - 1
      page * Settings.paginate.categories
    end
  end
end
