class BookingsController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource
  before_action :load_tour, except: :index
  before_action :load_booking, except: %i(index new create)
  before_action :is_approved?, only: :destroy
  before_action :is_canceled?, only: :cancel
  before_action :active_relation_blank, only: %i(show edit)

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
    else
      flash[:danger] = t "msg.action_fail"
    end
    redirect_back fallback_location: root_path
  end

  def cancel
    begin
      @booking.canceled!
      flash[:success] = t "msg.booking_canceled"
    rescue StandardError
      flash[:danger] = t "msg.action_fail"
    end
    redirect_back fallback_location: root_path
  end

  protected

  def is_approved?
    return unless @booking.approved?

    flash[:danger] = t "msg.action_fail"
    redirect_back fallback_location: root_path
  end

  def is_canceled?
    return unless @booking.canceled?

    flash[:danger] = t "msg.action_fail"
    redirect_back fallback_location: root_path
  end

  private

  def booking_params
    params.require(:booking).permit Booking::UPDATE_ATTRS
  end

  def load_tour
    @tour = Tour.find_by id: params[:tour_id].to_i
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
    @booking_relation = Booking.check_booking(params[:tour_id].to_i,
      params[:id])
    return unless @booking_relation.blank?

    flash[:danger] = t "msg.booking_inv"
    redirect_to tours_path
  end
end
