require "rails_helper"

RSpec.describe Booking, type: :model do
  describe "association tests" do
    it "should belongs to user" do
      should belong_to :user
    end

    it "should belongs to tour" do
      should belong_to :tour
    end
  end

  describe "validation tests" do
    it "enum statuses include" do
      should define_enum_for(:status).with_values %i(approved canceled in_progress)
    end

    context "name" do
      it "name should presence" do
        should validate_presence_of :name
      end

      it "valid length of name" do
        should validate_length_of(:name).is_at_least(Settings.length.name)
      end
    end

    context "phone" do
      it "phone should presence" do
        should validate_presence_of :phone
      end

      it "valid length of phone" do
        should validate_length_of(:phone).is_at_least(Settings.length.phone)
      end
    end

    it "should save successfully" do
      booking = Booking.new(name: "Nguyen", phone: "0702787675").save
      expect(booking).to eq(true)
    end
  end

  describe "delegate tests" do
    it "title delegate to tour" do
      should delegate_method(:title).to(:tour)
    end

    it "price delegate to tour" do
      should delegate_method(:price).to(:tour)
    end
  end

  describe "scope tests" do
  end
end
