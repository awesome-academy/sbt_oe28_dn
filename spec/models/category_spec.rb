require "rails_helper"

RSpec.describe Category, type: :model do
  describe "association tests" do
    it "should have many review" do
      should have_many :reviews
    end
  end

  describe "validation tests" do
    it "name should presence" do
      should validate_presence_of :name
    end
  end

  describe "scope tests" do
  end
end
