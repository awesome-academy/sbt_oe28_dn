require "rails_helper"

RSpec.describe Like, type: :model do

  describe "associations" do
    it "belong to user" do
      is_expected.to belong_to :user
    end

    it "belong to review" do
      is_expected.to belong_to :review
    end
  end
end
