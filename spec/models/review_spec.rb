require "rails_helper"

RSpec.describe Review, type: :model do

  describe "associations" do
    it "belong to user" do
      is_expected.to belong_to :user
    end

    it "belong to category" do
      is_expected.to belong_to :category
    end

    it "has many likes" do
      is_expected.to have_many(:likes).dependent :destroy
    end
  end

  describe "validations" do
    it "has description presence true" do
      is_expected.to validate_presence_of :description
    end

    it "is description limit maximum" do
      is_expected.to validate_length_of(:description).is_at_most(
        Settings.description)
    end

    it "has title presence true" do
      is_expected.to validate_presence_of :title
    end

    it "has content presence true" do
      is_expected.to validate_presence_of :content
    end

    it "has image presence true" do
      is_expected.to validate_presence_of :image
    end
  end
end
