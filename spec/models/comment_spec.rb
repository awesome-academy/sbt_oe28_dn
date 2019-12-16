require "rails_helper"

RSpec.describe Comment, type: :model do

  describe "associations" do
    it "has belong to user" do
      is_expected.to belong_to :user
    end
  end

  describe "has content presence" do
    it {is_expected.to validate_presence_of :content}
  end
end
