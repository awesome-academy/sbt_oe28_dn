class Admin::BookingsController < AdminController
  before_action :load_booking, only: [:approve, :is_approved?]
  before_action :is_approved?, only: :approve
  load_and_authorize_resource

  def index
    @bookings = Booking.newest.paginate(page: params[:page],
      per_page: Settings.paginate.bookings)
  end

  def ticket
    @tickets = Booking.joins(:tour).approved.newest.paginate(
      page: params[:page], per_page: Settings.paginate.bookings
    )
    @sum_ticket = Settings.zero
    return if @tickets.blank?

    @sum_ticket = @tickets.sum(:price).round(Settings.two)
  end

  def approve
    begin
      @booking.approved!
      flash[:success] = t "msg.booking_approved"
    rescue StandardError
      flash[:danger] = t "msg.action_fail"
    end
    redirect_to admin_bookings_path
  end

  protected

  def is_approved?
    return unless @booking.approved?

    flash[:danger] = t "msg.action_fail"
    redirect_to :back
  end

  private

  def load_booking
    @booking = Booking.find_by id: params[:id]
    return if @booking

    flash[:danger] = t "msg.booking_inv"
    redirect_to admin_tours_path
  end
end
