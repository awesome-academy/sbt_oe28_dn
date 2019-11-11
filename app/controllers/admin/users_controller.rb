class Admin::UsersController < AdminController
  before_action :load_user, except: %i(new create index)
  before_action :all_users, only: :index
  before_action :is_user?, only: :user
  before_action :is_admin?, only: [:admin, :destroy]
  load_and_authorize_resource

  def index; end

  def new
    @user = User.new
  end

  def create
    @user = User.new user_params
    if @user.save
      flash[:success] = t "msg.create_user_success"
      redirect_to admin_users_path
    else
      flash[:danger] = t "msg.create_user_fail"
      render :new
    end
  end

  def admin
    begin
      @user.admin!
      flash[:success] = t "msg.update_success"
    rescue StandardError
      flash[:danger] = t "msg.update_err"
    end
    redirect_to admin_users_path
  end

  def user
    begin
      @user.user!
      flash[:success] = t "msg.update_success"
    rescue StandardError
      flash[:danger] = t "msg.update_err"
    end
    redirect_to admin_users_path
  end

  def destroy
    if @user.destroy
      flash[:success] = t "msg.user_delete_success"
    else
      flash[:danger] = t "msg.user_delete_fail"
    end
    redirect_to admin_users_path
  end

  protected

  def is_user?
    return unless @user.user?

    flash[:danger] = t "msg.action_fail"
    redirect_back fallback_location: root_path
  end

  def is_admin?
    return unless @user.admin?

    flash[:danger] = t "msg.action_fail"
    redirect_back fallback_location: root_path
  end

  private

  def user_params
    params.require(:user).permit User::USER_PARAMS_ADMIN
  end

  def load_user
    @user = User.find params[:id]
  rescue StandardError
    flash[:danger] = t "msg.user_invalid"
    redirect_to admin_users_path
  end

  def all_users
    @users = User.newest.paginate page: params[:page],
       per_page: Settings.paginate.users
  end
end
