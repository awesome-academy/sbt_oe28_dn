class RegistrationsController < Devise::RegistrationsController
  def new
    super
  end

  def create
    @user = User.new user_params
    super
  end

  def update
    @user.update_attributes user_params_update
    super
  end

  private

  def user_params
    params.require(:user).permit User::USER_PARAMS
  end

  def user_params_update
    params.require(:user).permit User::USER_PARAMS_UPDATE
  end
end
