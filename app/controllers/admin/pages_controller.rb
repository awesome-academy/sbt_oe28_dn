class Admin::PagesController < ApplicationController
  layout "admin"
  before_action :logged_in_user, :check_is_admin
  def home; end
end
