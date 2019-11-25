class Users::OmniauthCallbacksController < ApplicationController
  def facebook
    callback :facebook
  end

  def google_oauth2
    callback :google_oauth2
  end

  def callback provider
    user = User.from_omniauth request.env["omniauth.auth"]
    if user.persisted?
      flash[:success] = t ".success"
      sign_in_and_redirect user, event: :authenticate
    else
      session["devise.#{provider}_data"] =
        request.env["omniauth.auth"].except(:extra)
      flash[:danger] = t ".fail"
      redirect_to new_user_registration_path
    end
  end
end
