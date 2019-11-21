class UsersController < ApplicationController
  layout "users_sessions"
  before_action :load_user

  def show; end

  private

  def load_user
    @user = User.find_by id: params[:id]
    return if @user
    flash[:danger] = t "msg.user_invalid"
    redirect_to root_path
  end
end
