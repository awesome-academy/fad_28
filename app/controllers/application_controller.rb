class ApplicationController < ActionController::Base
  include ProductsHelper
  include Pagy::Backend

  before_action :load_language, :setup_cart, :load_search_object
  before_action :config_params_devise, if: :devise_controller?

  rescue_from CanCan::AccessDenied do
    flash[:danger] = I18n.t(".exception")
    redirect_to root_path
  end

  rescue_from ActiveRecord::RecordNotFound do
    flash[:danger] = I18n.t(".not_found")
    redirect_to root_path
  end

  def setup_cart
    session[:cart] ||= {}
    @cart = session[:cart]
  end

  def only_admin
    return if current_user.admin?
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

  def load_search_object
    @produce = Product.includes(:category).ransack params[:q]
    @products = @produce.result.paginate page: params[:page],
      per_page: Settings.items
  end
end
