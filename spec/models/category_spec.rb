require "rails_helper"

RSpec.describe Category, type: :model do
  let(:category) {FactoryBot.create :category}

  subject {category}

  it "has a valid factory" do
    is_expected.to be_valid
  end

  it "is a Category" do
    is_expected.to be_a_kind_of Category
  end

  describe "associations" do
    it "has many reviews" do
      is_expected.to have_many(:reviews)
    end
  end

  describe "validate has name presence" do
    it {is_expected.to validate_presence_of :name}
  end
end
