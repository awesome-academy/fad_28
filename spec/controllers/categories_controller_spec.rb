require "rails_helper"

RSpec.describe CategoriesController, type: :controller do
  before :each do
    @request.env["devise.mapping"] = Devise.mappings[:user]
    user = FactoryBot.create :user
    user.confirm
    sign_in user
  end

  let(:category){FactoryBot.create :category}

  context "GET #index" do
    it "response successful" do
      get :index
      should respond_with :ok
      should render_with_layout :application
      should render_template :index
    end
  end

  context "GET #new" do
    it "render new category form" do
      get :new
      should respond_with :ok
      should render_template :new
    end
  end

  context "GET #edit" do
    it "render edit category form" do
      get :edit, params: {id: category.id}
      should respond_with :ok
      should render_template :edit
    end
  end

  context "POST #create" do
    it "new category successful" do
      params = {category: {name: Faker::Name.name}}
      post :create, params: params
      should redirect_to categories_path
      should set_flash
    end

    it "new category failure" do
      params = {category: {name: nil}}
      post :create, params: params
      should render_template :new
    end
  end

  context "PUT #update" do
    it "category successful" do
      params = {name: Faker::Name.name}
      put :update, params: {id: category.id, category: params}
      should redirect_to categories_path
      should set_flash
    end

    it "category failure" do
      params = {name: nil}
      put :update, params: {id: category.id, category: params}
      should render_template :edit
      should set_flash
    end
  end

  context "DELETE #destroy" do
    it "category successful" do
      delete :destroy, params: {id: category.id}
      should redirect_to categories_path
      should set_flash
    end
  end
end
