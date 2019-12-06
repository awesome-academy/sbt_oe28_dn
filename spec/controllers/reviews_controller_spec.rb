require "rails_helper"

RSpec.describe ReviewsController, type: :controller do
  let(:user){FactoryBot.create(:user)}
  before do
    sign_in user
  end
  let(:review){FactoryBot.create(:review, user: user)}
  let(:review_without_title) do
    {review:
      {title: "", content: "this is content", description: "this is description", image: "image.png", category_id: 1
      }
    }
  end
  let(:review_success) do
    {review:
      {title: "this is new title", description: "this is new description", content: "this is new content", category_id: 2, image: "imagenew.png"
      }
    }
  end

  describe "GET show review" do
    context "when success " do
      before do
        get :show, params: {id: review.id}
      end
      it "show review" do
        expect(assigns(:review)).to eq(review)
      end

      it "render template show" do
        expect(response).to render_template :show
      end

      it "status is redirect and redirect" do
          expect(response).to have_http_status 200
      end

      it "check author of review" do
        expect(assigns(:review).user_id).to eq(user.id)
      end
    end

    context "when not found" do
      before do
        get :show, params: {id: 1000}
      end
      it "status is redirect and redirect" do
          expect(response).to have_http_status 302
      end
      it "when not found review" do
        expect(response).to redirect_to root_path
      end
    end
  end

  describe "GET new" do
    before do
      get :new
    end
    it "should render right template view" do
      expect(response).to render_template(:new)
    end
    it "should create a new review" do
      expect(assigns :review).to be_a_new(Review)
    end
  end

  describe "POST #create" do
    let(:count_review){Review.all.count}
    context "with valid " do
      it "review create success" do
        count = count_review
        review
        expect(Review.all.count).to eq(count +1)
      end
    end
    context "with invalid " do
      before do
        post :create, params: review_without_title
      end
      it "should create review fail without title" do
        expect(Review.all.count).to eq count_review
      end
      it "should create review fail message" do
        expect(flash[:danger]).to eq(I18n.t "msg.create_review_fail")
      end
    end
  end

  describe "GET edit" do
    before do
      get :edit, params: {id: review.id}
    end
    it "should render right template view" do
      expect(response).to render_template(:edit)
    end
    it "should edit a review" do
      expect(assigns(:review)).to eq review
    end
  end
end
