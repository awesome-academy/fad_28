module SessionHelper
  def signin user
    session[:user] = user.id
  end

  def remember user
    user.save_remember_token
    cookies.permanent.signed[:user] = user.id
    cookies.permanent[:remember_token] = user.remember_token
  end

  def forget user
    user.forget_remember_token
    cookies.delete :user
    cookies.delete :remember_token
  end

  def current_user
    if session[:user]
      @current_user ||= User.find_by id: session[:user]
    elsif cookies.signed[:user]
      user = User.find_by id: cookies.signed[:user]
      if user&.authenticate?(:remember, cookies[:remember_token])
        signin user
        @current_user = user
      end
    end
  end

  def signed_in
    return if current_user.present?
    redirect_to signin_path
  end

  def signed_out
    return if current_user.nil?
    redirect_to current_user
  end

  def sign_out
    forget current_user
    session.delete :user
    @current_user = nil
  end

  def only_admin
    return if current_user.admin?
    redirect_to root_path
  end

  def allow_signup
    return if current_user.nil? || current_user.admin?
    redirect_to current_user
  end
end
