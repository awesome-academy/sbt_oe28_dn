class Admin::ToursController < AdminController
  before_action :load_tour, except: %i(index new create)
  before_action :stt, only: :index

  def index
    @tours = Tour.order("created_at desc").paginate(page: params[:page],
      per_page: Settings.paginate.tours)
  end

  def show; end

  def edit; end

  def new
    @tour = current_user.tours.build
  end

  def create
    @tour = current_user.tours.build tour_params
    if @tour.save
      flash[:info] = t "msg.approved"
      render :show
    else
      render :new
    end
  end

  def update
    @tour.attributes = tour_params
    if @tour.save
      flash[:success] = t "msg.update"
      render :show
    else
      flash[:danger] = t "msg.update_err"
      render :edit
    end
  end

  def destroy
    return unless @tour.destroy
    flash[:success] = t "msg.del"
    redirect_to admin_tours_path
  end

  private

  def tour_params
    params.require(:tour).permit Tour::UPDATE_ATTRS
  end

  def load_tour
    @tour = Tour.find_by id: params[:id]
    return if @tour

    flash[:danger] = t "msg.tour_inv"
    redirect_to admin_tours_path
  end

  def stt
    params[:page] = 1 unless params[:page]
    @stt = Settings.paginate.bookings * (params[:page].to_i - 1)
  end
end
