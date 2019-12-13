require "rails_helper"

RSpec.describe HomeController, type: :controller do
  context "GET #index" do
    it "response successful" do
      get :index
      should respond_with :ok
      should render_with_layout :application
      should render_template :index
    end
  end
end
