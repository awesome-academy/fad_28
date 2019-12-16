require "rails_helper"

RSpec.describe Product, type: :model do
  context "association" do
    it "should belong to the category" do
      is_expected.to belong_to :category
    end

    it "has many the evaluates" do
      is_expected.to have_many :evaluates
    end

    it "has many the order items" do
      is_expected.to have_many :order_items
    end
  end

  context "validation" do
    it "for name attribute" do
      is_expected.to validate_presence_of :name
    end

    it "for image attribute" do
      is_expected.to validate_presence_of :image
    end

    it "category foreign key can't be blank" do
      is_expected.to validate_presence_of :category_id
    end

    it "for price attribute" do
      is_expected.to validate_presence_of :price
      is_expected.to validate_numericality_of(:price)
        .is_greater_than Settings.smallest.of_price
    end

    it "for discount attribute" do
      is_expected.to validate_numericality_of(:discount)
        .is_greater_than(Settings.smallest.of_discount)
        .is_less_than(Settings.biggest.of_discount).allow_nil
    end
  end
end
