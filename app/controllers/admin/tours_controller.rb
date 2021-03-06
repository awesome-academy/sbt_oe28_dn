class Admin::ToursController < AdminController
  before_action :load_tour, except: %i(index new create)

  def index
    @tours = Tour.newest.paginate(page: params[:page],
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
      flash[:danger] = t "msg.action_fail"
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
    if @tour.destroy
      flash[:success] = t "msg.del"
      redirect_to admin_tours_path
    else
      flash[:danger] = t "msg.action_fail"
      render :index
    end
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
end
