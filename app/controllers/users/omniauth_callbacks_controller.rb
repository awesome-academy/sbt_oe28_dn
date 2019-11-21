class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def google_oauth2
    @user = User.from_omniauth request.env["omniauth.auth"]
    if @user.nil?
      flash[:danger] = t "devise.omniauth_callbacks.failure"
    else
      flash[:success] = t "devise.omniauth_callbacks.success"
      sign_in @user
    end
    redirect_to root_path
  end
end
