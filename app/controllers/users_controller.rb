class UsersController < ApplicationController
  layout "users_sessions"
  before_action :authenticate_user!, :load_user
  load_and_authorize_resource

  def show; end

  private

  def user_params
    params.require(:user).permit User::USER_PARAMS
  end

  def load_user
    @user = User.find params[:id]
  rescue StandardError
    flash[:danger] = t "msg.user_invalid"
    redirect_to root_path
  end
end
