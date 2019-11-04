class ChangePasswordController < ApplicationController
  before_action :signed_in, :load_user, :valid_old_password

  def update
    if @user.update user_params
      flash[:success] = t ".success"
      sign_out
      redirect_to signin_path
    else
      flash.now[:danger] = t ".fail"
      render "users/show"
    end
  end

  private

  def valid_old_password
    return if @user.authenticate? :password, params[:user][:old_password]
    flash[:danger] = t ".not_match"
    redirect_to @user
  end

  def user_params
    params.require(:user).permit :password, :password_confirmation
  end
end
