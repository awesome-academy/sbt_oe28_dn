require "rails_helper"

RSpec.describe UsersController, type: :controller do
  let(:user){FactoryBot.create(:user)}
  before do
    sign_in user
  end
  describe "GET show" do
    context "when success " do
      before do
        get :show, params: {id: user.id}
      end
      it "show user" do
        expect(assigns(:user)).to eq(user)
      end
    end

    context "when not found" do
      before do
        get :show, params: {id: 1000}
      end
      it "when not found user messega" do
        expect(flash[:danger]).to eq(I18n.t("msg.user_invalid"))
      end

      it "when not found user redirect to" do
        expect(response).to redirect_to root_path
      end
    end
  end
end
