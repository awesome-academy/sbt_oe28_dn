module UsersHelper
  def page_user
    if params[:page].nil? || params[:page] == Settings.one
      0
    else
      page = params[:page].to_i - 1
      page * Settings.paginate.users
    end
  end
end
