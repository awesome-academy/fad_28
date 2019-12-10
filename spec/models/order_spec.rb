require "rails_helper"

RSpec.describe Order, type: :model do
  context "association" do
    it "should belong to the payment" do
      is_expected.to belong_to :payment
    end

    it "has many the order items" do
      is_expected.to have_many :order_items
    end
  end

  context "validation" do
    it "for email attribute" do
      is_expected.to validate_presence_of :email
      is_expected.to allow_value("thuc@gmail.com").for :email
      is_expected.to validate_length_of(:email).is_at_most Settings.size.of_email
    end

    it "for name attribute" do
      is_expected.to validate_presence_of :name
      is_expected.to validate_length_of(:name).is_at_most Settings.size.of_name
    end

    it "for phone number attribute" do
      is_expected.to validate_numericality_of :phone
    end

    it "for address attribute" do
      is_expected.to validate_presence_of :address
      is_expected.to validate_length_of(:address).is_at_most Settings.size.address
    end

    it "payment foreign key can't be blank" do
      is_expected.to validate_presence_of :payment_id
    end

    it "should define enum for status" do
      is_expected.to define_enum_for :status_id
    end
  end
end
