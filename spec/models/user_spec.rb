require "rails_helper"

RSpec.describe User, type: :model do
  context "association" do
    it "has many evaluates" do
      is_expected.to have_many :evaluates
    end

    it "has many suggests" do
      is_expected.to have_many :suggests
    end
  end

  context "validation" do
    it "for name attribute" do
      is_expected.to validate_presence_of :name
      is_expected.to validate_length_of(:name).is_at_most Settings.size.of_name
    end

    it "for phone number attribute" do
      is_expected.to validate_numericality_of(:phone).allow_nil
    end

    it "should define enum for role" do
      is_expected.to define_enum_for :role_id
    end
  end
end
