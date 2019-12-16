require "rails_helper"

RSpec.describe Tour, type: :model do

  describe "associations" do
    it "belong to user" do
      is_expected.to belong_to :user
    end
  end

  describe "validations" do
    it "has title presence true" do
      is_expected.to validate_presence_of :title
    end

    it "is title limit minimum" do
      is_expected.to validate_length_of(:title).is_at_least(
        Settings.length.title)
    end

    it "has description presence true" do
      is_expected.to validate_presence_of :description
    end

    it "is description limit maximum" do
      is_expected.to validate_length_of(:description).is_at_most(
        Settings.length.description)
    end

    it "has content presence true" do
      is_expected.to validate_presence_of :content
    end

    it "is content limit maximum" do
      is_expected.to validate_length_of(:content).is_at_most(
        Settings.length.content)
    end

    it "has date_in presence true and allow nil " do
      is_expected.to validate_presence_of(:date_in).allow_nil
    end

    it "has date_out presence true and allow nil" do
      is_expected.to validate_presence_of(:date_out).allow_nil
    end

    it "has image presence true" do
      is_expected.to validate_presence_of :image
    end

    it "has price greater than 0" do
      is_expected.to validate_numericality_of(:price).
         is_greater_than Settings.zero
    end
  end
end

