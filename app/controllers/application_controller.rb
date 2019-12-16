class ApplicationController < ActionController::Base
  layout :layout_by_resource
  protect_from_forgery with: :exception
  before_action :set_locale, :load_categories
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit :sign_up, keys: [:full_name]
    devise_parameter_sanitizer.permit :account_update, keys: [:full_name]
  end

  private

  rescue_from CanCan::AccessDenied do
    flash[:danger] = t "msg.user"
    redirect_back fallback_location: root_path
  end

  rescue_from ActiveRecord::RecordNotFound do
    flash[:danger] = t "msg.booking_inv"
    redirect_back fallback_location: root_path
  end

  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end

  def default_url_options
    {locale: I18n.locale}
  end

  def load_categories
    @categories = Category.newest
  end

  def check_is_admin
    return if current_user.admin?
    flash[:danger] = t "msg.not_admin"
    redirect_to root_path
  end

  def layout_by_resource
    if devise_controller?
      "users_sessions"
    else
      "application"
    end
  end
end
