class AdminController < ApplicationController
  layout "admin"
  before_action :authenticate_user!, :check_is_admin
end
