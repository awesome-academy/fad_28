class ChangeAvatarController < ApplicationController
  before_action :authenticate_user!, :valid_params

  def update
    if current_user.update_attribute :image, params[:user][:image]
      flash[:success] = t ".success"
    else
      flash[:danger] = t ".fail"
    end
    redirect_back fallback_location: root_path
  end

  private

  def valid_params
    return if params[:user]
    flash[:warning] = t ".not_change"
    redirect_to @user
  end
end
