class SessionController < ApplicationController
  before_action :signed_out, only: [:new, :create]
  before_action :load_user, only: :create
  before_action :signed_in, only: :destroy

  def new; end

  def create
    signin @user
    remember @user if params[:session][:remember] == Settings.remembered
    flash[:success] = t ".success"
    redirect_to @user
  end

  def destroy
    sign_out
    flash[:success] = t ".signout"
    redirect_to root_path
  end

  private

  def load_user
    @user = User.find_by email: params[:session][:email]
    return if @user&.authenticate params[:session][:password]
    flash.now[:danger] = t ".invalid"
    render :new
  end
end
