class ApplicationController < ActionController::Base
  include SessionsHelper

  protect_from_forgery with: :exception
  before_action :set_locale, :load_categories
  before_action :configure_permitted_parameters, if: :devise_controller?

  rescue_from CanCan::AccessDenied do |exception|
    respond_to do |format|
      if current_user.user?
        format.html{redirect_to root_path, notice: exception.message}
      else
        format.html{redirect_to admin_root_path, notice: exception.message}
      end
    end
  end

  private
  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end

  def default_url_options
    {locale: I18n.locale}
  end

  def load_tour
    @tour = Tour.find_by id: params[:id]
    return if @tour

    flash[:danger] = t "msg.tour_inv"
    redirect_to tours_path
  end

  def load_categories
    @categories = Category.all
  end

  def check_is_admin
    return if current_user.admin?
    flash[:danger] = t "msg.not_admin"
    redirect_to root_path
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit :sign_up, keys: User::USER_PARAMS
  end
end
