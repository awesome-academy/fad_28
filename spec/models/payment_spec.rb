require "rails_helper"

RSpec.describe Payment, type: :model do
  context "association" do
    it "has many the orders" do
      is_expected.to have_many :orders
    end
  end

  context "validation" do
    it "for name attribute" do
      is_expected.to validate_presence_of :name
      is_expected.to validate_uniqueness_of(:name).case_insensitive
    end
  end
end
