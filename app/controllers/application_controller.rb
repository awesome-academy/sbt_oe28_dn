class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :set_locale, :load_categories
  before_action :configure_permitted_parameters, if: :devise_controller?

  include SessionsHelper

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
    return if current_user.is_admin?
    flash[:danger] = t "msg.not_admin"
    redirect_to root_path
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit :sign_up, keys: User::USER_PARAMS
  end
end
