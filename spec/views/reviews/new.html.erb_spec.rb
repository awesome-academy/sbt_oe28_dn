require "rails_helper"

RSpec.describe "reviews/new.html.erb", type: :view do
  let(:category){FactoryBot.create(:category)}
  let(:categories){Category.all}
  let(:review) {Review.new}
  subject {rendered}
  before do
    assign :category, category
    assign :categories, categories
    assign :review, review
    user = FactoryBot.create :user
    allow(view).to receive(:current_user).and_return user
    render
  end

  describe "reviews/new.html.erb" do
    it "presence review" do
      expect(review).to be_present
    end

    it "presence categories" do
      expect(categories).to be_present
    end

    it "presence category" do
      expect(category).to be_present
    end

    it "has field title" do
      is_expected.to have_field "review[title]"
    end

    it "has field description" do
      is_expected.to have_field "review[description]"
    end

    it "has field content" do
      is_expected.to have_field "review[content]"
    end

    it "has field option category_id" do
      is_expected.to have_select "review[category_id]"
    end

    it "has field image" do
      is_expected.to have_field "review[image]"
    end

    it "has submit button" do
     have_submit_button I18n.t("form.submit")
    end
  end
end
