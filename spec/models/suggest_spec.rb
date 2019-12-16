require "rails_helper"

RSpec.describe Suggest, type: :model do
  context "association" do
    it "should belong to user" do
      is_expected.to belong_to :user
    end
  end

  context "validation" do
    it "for product name attribute" do
      is_expected.to validate_presence_of :product_name
    end

    it "for image attribute" do
      is_expected.to validate_presence_of :image
    end

    it "user foreign key can't be blank" do
      is_expected.to validate_presence_of :user_id
    end
  end
end
