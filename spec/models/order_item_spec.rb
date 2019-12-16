require "rails_helper"

RSpec.describe OrderItem, type: :model do
  context "association" do
    it "should belong to the product" do
      is_expected.to belong_to :product
    end

    it "should belong to the order" do
      is_expected.to belong_to :order
    end
  end

  context "validation" do
    it "product foreign key can't be blank" do
      is_expected.to validate_presence_of :product_id
    end

    it "order foreign key can't be blank" do
      is_expected.to validate_presence_of :order_id
    end

    it "for quantity attribute" do
      is_expected.to validate_presence_of :quantity
      is_expected.to validate_numericality_of(:quantity).only_integer
        .is_greater_than(Settings.smallest.of_quantity)
        .is_less_than Settings.biggest.of_quantity
    end
  end
end
