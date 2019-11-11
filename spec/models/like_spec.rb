require "rails_helper"

RSpec.describe Like, type: :model do
  describe "association tests " do
    it "should belong to user" do
      should belong_to :user
    end

    it "should belong to review" do
      should belong_to :review
    end
  end

  describe "scope tests" do
  end
end
