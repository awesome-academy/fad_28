class ResetPasswordController < ApplicationController
  before_action :signed_out
  before_action :find_user, only: :create
  before_action :load_user, :valid_user, only: [:edit, :update]

  def new; end

  def edit; end

  def create
    @user.save_reset_password_token
    @user.send_email_reset_password
    flash[:success] = t ".sent"
    redirect_to root_path
  end

  def update
    if params[:user][:password].empty?
      @user.errors.add :password, t(".blank")
      render :edit
    elsif @user.update user_params
      signin @user
      @user.clear_reset_password_token
      flash[:success] = t ".success"
      redirect_to @user
    else
      render :edit
    end
  end

  private

  def find_user
    @user = User.find_by email: params[:reset][:email]
    return if @user
    flash[:danger] = t ".not_found"
    redirect_to forget_password_path
  end

  def load_user
    @user = User.find_by email: params[:email]
    return if @user
    flash[:danger] = t ".not_found"
    redirect_to root_path
  end

  def valid_user
    return if @user&.authenticate?(:reset_password, params[:id])
    flash[:danger] = t ".invalid"
    redirect_to root_path
  end

  def user_params
    params.require(:user).permit :password, :password_confirmation
  end
end
