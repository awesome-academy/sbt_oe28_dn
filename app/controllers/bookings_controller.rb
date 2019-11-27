class BookingsController < ApplicationController
  before_action :logged_in_user
  before_action :find_tour, except: :index
  before_action :load_booking, except: %i(index new create)
  before_action :active_relation_blank, :correct_user, only: %i(show edit)

  def index
    @manages = current_user.bookings.newest.paginate(page: params[:page],
      per_page: Settings.paginate.bookings)
  end

  def new
    @booking = current_user.bookings.build
  end

  def create
    @booking = current_user.bookings.build booking_params
    @booking.tour_id = @tour.id
    @booking.date_in = @tour.date_in
    @booking.date_out = @tour.date_out
    @booking.price = @tour.price
    if @booking.save
      flash[:info] = t "msg.booking_succeeded"
      redirect_to tour_booking_path(@tour, @booking)
    else
      flash[:danger] = t "msg.booking_failed"
      render :new
    end
  end

  def show; end

  def edit; end

  def update
    @booking.attributes = booking_params
    if @booking.save
      flash[:success] = t "msg.update_success"
      redirect_to @tour
    else
      flash[:danger] = t "msg.update_fail"
      render :edit
    end
  end

  def destroy
    if @booking.destroy
      flash[:success] = t "msg.del"
      redirect_to @tour
    else
      flash[:danger] = t "msg.action_fail"
      render :index
    end
  end

  def approve
    if @booking.approved!
      flash[:success] = t "msg.booking_approved"
    else
      flash[:danger] = t "msg.action_fail"
    end
    redirect_to admin_bookings_path
  end

  def cancel
    if @booking.canceled!
      flash[:success] = t "msg.booking_canceled"
    else
      flash[:danger] = t "msg.action_fail"
    end
    redirect_to(:back)
  end

  protected

  def correct_user
    return if current_user.id == @booking.user_id

    flash[:danger] = t "msg.user"
    redirect_to tours_path
  end

  private

  def booking_params
    params.require(:booking).permit Booking::UPDATE_ATTRS
  end

  def find_tour
    @tour = Tour.find_by id: params[:tour_id]
    return if @tour

    flash[:danger] = t "msg.tour_inv"
    redirect_to tours_path
  end

  def load_booking
    @booking = Booking.find_by id: params[:id]
    return if @booking

    flash[:danger] = t "msg.booking_inv"
    redirect_to tours_path
  end

  def active_relation_blank
    @booking_relation = Booking.check_booking(params[:tour_id], params[:id])
    return unless @booking_relation.blank?

    flash[:danger] = t "msg.booking_inv"
    redirect_to tours_path
  end
end
