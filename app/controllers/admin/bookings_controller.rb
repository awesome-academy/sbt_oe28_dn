class Admin::BookingsController < AdminController
  def index
    @bookings = Booking.newest.paginate(page: params[:page],
      per_page: Settings.paginate.bookings)
  end

  def ticket
    @tickets = Booking.approved.newest.paginate(
      page: params[:page], per_page: Settings.paginate.bookings
    )
    @sum_ticket = 0
    return if @tickets.blank?
    @sum_ticket = @tickets.sum(:price).round(2)
  end
end
