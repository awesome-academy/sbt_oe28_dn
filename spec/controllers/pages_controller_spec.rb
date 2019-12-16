require "rails_helper"

RSpec.describe PagesController, type: :controller do
  describe "#home" do
    it "responds successfully" do
      get :home
      should respond_with :ok
      should render_with_layout :application
      should render_template :home
    end
  end
end
