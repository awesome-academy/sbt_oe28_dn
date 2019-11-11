class Admin::BookingsController < AdminController
  before_action :load_booking, :find_tour, only: %i(approve cancel)
  before_action :stt, only: %i(index ticket)

  def index
    @bookings = Booking.order("created_at desc").paginate(page: params[:page],
      per_page: Settings.paginate.bookings)
  end

  def ticket
    @tickets = Booking.ticket(params[:status]).paginate(page: params[:page],
      per_page: Settings.paginate.bookings).order("created_at desc")
    @sum_ticket = if @tickets.blank?
                    0
                  else
                    @tickets.sum(:price).round(2)
                  end
  end

  def approve
    @booking.update_attributes status: Settings.booking_status.approved
    flash[:success] = t "msg.booking_approved"
    redirect_to admin_bookings_path
  end

  def cancel
    @booking.update_attributes status: Settings.booking_status.canceled
    flash[:success] = t "msg.booking_canceled"
    redirect_to admin_bookings_path
  end

  private

  def load_booking
    @booking = Booking.find_by id: params[:id]
    return if @booking

    flash[:danger] = t "msg.booking_inv"
    redirect_to admin_bookings_path
  end

  def find_tour
    @tour = Tour.find_by id: params[:tour_id]
    return if @tour

    flash[:danger] = t "msg.tour_inv"
    redirect_to admin_bookings_path
  end

  def stt
    params[:page] = 1 unless params[:page]
    @stt = Settings.paginate.bookings * (params[:page].to_i - 1)
  end
end
