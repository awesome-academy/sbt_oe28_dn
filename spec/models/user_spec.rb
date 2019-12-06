require "rails_helper"

RSpec.describe User, type: :model do
  let(:user) {FactoryBot.create :user}

  subject {user}

  it "has a valid factory" do
    is_expected.to be_valid
  end

  it "is a User" do
    is_expected.to be_a_kind_of User
  end

  describe "associations" do
    it "has many tours" do
      is_expected.to have_many(:tours)
    end
    it "has many comments" do
      is_expected.to have_many(:comments).dependent :destroy
    end
    it "has many likes" do
      is_expected.to have_many(:likes).dependent :destroy
    end

    it "has many reviews" do
      is_expected.to have_many(:reviews).dependent :destroy
    end
  end

  describe "has full name" do
    it {is_expected.to validate_presence_of :full_name}
    it "is limit maximum" do
      is_expected.to validate_length_of(:full_name).is_at_most(
        Settings.full_name)
    end
  end

  describe "is email" do
    it {is_expected.to validate_presence_of :email}
    it {is_expected.to validate_uniqueness_of(:email).case_insensitive}
    it "is invalid email" do
      user.email = "example"
      is_expected.not_to be_valid
    end
  end
end
