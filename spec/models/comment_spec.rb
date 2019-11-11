require "rails_helper"

RSpec.describe Comment, type: :model do
  describe "association tests" do
    it "should belong to user" do
      should belong_to :user
    end
  end

  describe "validation tests" do
    it "content should presence" do
      should validate_presence_of :content
    end
  end

  describe "scope tests" do
  end
end
