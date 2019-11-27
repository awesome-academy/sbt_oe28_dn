class AdminController < ApplicationController
  layout "admin"
  before_action :user_signed_in?, :check_is_admin
end
