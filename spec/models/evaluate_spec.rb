require "rails_helper"

RSpec.describe Evaluate, type: :model do
  context "association" do
    it "should belong to user" do
      is_expected.to belong_to :user
    end

    it "should belong to product" do
      is_expected.to belong_to :product
    end
  end

  context "validation" do
    it "user foreign key can't be blank" do
      is_expected.to validate_presence_of :user_id
    end

    it "product foreign key can't be blank" do
      is_expected.to validate_presence_of :product_id
    end

    it "for star attribute" do
      is_expected.to validate_numericality_of(:star).only_integer
        .is_greater_than(Settings.smallest.of_star)
        .is_less_than Settings.biggest.of_star
    end

    it "for content attribute" do
      is_expected.to validate_presence_of :content
    end
  end
end
