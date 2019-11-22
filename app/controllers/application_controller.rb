class ApplicationController < ActionController::Base
  include ProductsHelper

  before_action :load_language, :setup_cart
  before_action :config_params_devise, if: :devise_controller?

  def setup_cart
    session[:cart] ||= {}
    @cart = session[:cart]
  end

  def only_admin
    return if current_user.admin?
    redirect_to root_path
  end

  def load_user
    @user = User.find_by id: params[:id]
    return if @user
    flash[:danger] = t ".not_found"
    redirect_to root_path
  end

  def load_category
    @categories = Category.all
  end

  def load_order
    @order = Order.find_by id: params[:id]
    return if @order
    flash[:danger] = t ".not_found"
    redirect_to orders_path
  end

  private

  def load_language
    return I18n.locale = I18n.default_locale unless params[:locale]
    if I18n.available_locales.include? params[:locale].to_sym
      I18n.locale = params[:locale]
    else
      flash[:danger] = I18n.t(".not_support")
    end
  end

  def default_url_options
    {locale: I18n.locale}
  end

  def config_params_devise
    devise_parameter_sanitizer.permit :sign_up, keys: [:name]
  end
end
