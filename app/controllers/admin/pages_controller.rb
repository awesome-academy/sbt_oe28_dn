class Admin::PagesController < AdminController
  before_action :authenticate_user!
  authorize_resource class: false
  def home; end
end
