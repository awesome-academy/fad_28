require "rails_helper"

RSpec.describe UsersController, type: :controller do
  before :each do
    @request.env["devise.mapping"] = Devise.mappings[:user]
    @user = FactoryBot.create :user
    @user.confirm
    sign_in @user
  end

  context "GET #index" do
    it "respone successful" do
      get :index
      should respond_with :ok
      should render_with_layout :application
      should render_template :index
    end
  end

  context "GET #show" do
    it "response successful" do
      get :show, params: {id: @user.id}
      should respond_with :ok
    end

    it "response failure" do
      get :show, params: {id: 0}
      should respond_with 302
    end
  end

  context "GET #new" do
    it "render new user form" do
      get :new
      should respond_with :ok
      should render_template :new
    end
  end

  context "GET #edit" do
    it "render edit user form" do
      get :edit, params: {id: @user.id}
      should respond_with :ok
      should render_template :edit
    end

    it "not render edit form" do
      get :edit, params: {id: 0}
      should respond_with 302
      should set_flash
    end
  end

  context "POST #create" do
    it "new user successful" do
      params = {user: {name: Faker::Name.name, email: Faker::Internet.email,
        password: "123456", password_confirmation: "123456", role_id: :customer}}
      post :create, params: params
      should redirect_to users_path
      should set_flash
    end

    it "render form error" do
      params = {user: {name: nil, email: nil, password: nil,
        password_confirmation: nil, role_id: nil}}
      post :create, params: params
      should render_template :new
    end
  end

  context "PATCH #update" do
    before do
      @params = {name: @user.name, address: Faker::Lorem.paragraph,
        phone: Faker::Number.number(digits: 10), gender: 1}
    end
    it "info user successful" do
      patch :update, params: {id: @user.id, user: @params}
      should redirect_to @user
      should set_flash
    end

    it "render form error" do
      params = {name: @user.name, address: Faker::Lorem.paragraph, phone: nil, gender: 1}
      patch :update, params: {id: @user.id, user: params}
      should render_template :edit
      should set_flash
    end

    it "can't update incorect user" do
      patch :update, params: {id: 0, user: @params}
      should respond_with 302
      should set_flash
    end
  end

  context "DELETE #destroy" do
    it "delete user successful" do
      delete :destroy, params: {id: @user.id}
      should redirect_to users_path
      should set_flash
    end
  end
end
