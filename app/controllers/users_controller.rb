class UsersController < ApplicationController
  before_action :load_user, only: :show

  def show; end

  def new
    @user = User.new
  end

  def create
    @user = User.new user_params
    if @user.save
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
end
