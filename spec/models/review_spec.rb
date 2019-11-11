require "rails_helper"

RSpec.describe Review, type: :model do
  #carrier wave rspec test
  describe "association tests" do
    it "should belong to user" do
      should belong_to :user
    end

    it "should belong to category optional" do
      should belong_to(:category).optional
    end
  end

  describe "validation tests" do
    context "description" do
      it "description should presence" do
        should validate_presence_of :description
      end

      it "valid length of description" do
        should validate_length_of(:description).is_at_most(Settings.description)
      end
    end

    context "title" do
      it "title should presence" do
        should validate_presence_of :title
      end
    end
  end
end
