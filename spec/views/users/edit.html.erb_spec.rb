require "rails_helper"

RSpec.describe "users/edit.html.erb", type: :view do
  before :each do
    user = FactoryBot.create :user
    allow(view).to receive(:current_user).and_return user
  end

  context "render form edit" do
    before do
      assign(:user, User.new)
      render
    end

    it "will return fields" do
      rendered.should have_field("user[name]")
      rendered.should have_field("user[phone]")
      rendered.should have_field("user[address]")
      rendered.should have_field("user[gender]")
    end

    it "no includes a partial to edit" do
      controller.request.path_parameters["action"].should be_nil
    end
  end
end
