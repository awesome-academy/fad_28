class UsersController < ApplicationController
  before_action :signed_in, :load_user, :correct_user, only: :show
  before_action :signed_out, only: [:new, :create]

  def show; end

  def new
    @user = User.new
  end

  def create
    @user = User.new user_params
    if @user.save
      signin @user
      redirect_to @user
      flash[:success] = t ".saved"
    else
      render :new
    end
  end

  private

  def load_user
    @user = User.find_by id: params[:id]
    return if @user
    flash[:danger] = t ".not_found"
    redirect_to root_path
  end

  def user_params
    params.require(:user).permit :role_id, :email, :password,
      :password_confirmation, :name, :gender, :address, :phone
  end

  def correct_user
    return if current_user == @user
    redirect_to current_user
  end
end
