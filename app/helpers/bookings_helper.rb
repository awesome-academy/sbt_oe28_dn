module BookingsHelper
  def page_booking
    if params[:page].nil? || params[:page] == Settings.one
      0
    else
      page = params[:page].to_i - 1
      page * Settings.paginate.bookings
    end
  end
end
