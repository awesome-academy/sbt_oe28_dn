require "rails_helper"

RSpec.describe Rating, type: :model do
  describe "association tests" do
    it "should belong to tour" do
      should belong_to :tour
    end

    it "should belong to user" do
      should belong_to :user
    end
  end

  describe "scope tests" do
  end
end
