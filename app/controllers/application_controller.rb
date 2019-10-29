class ApplicationController < ActionController::Base
  include SessionHelper

  before_action :load_language

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
end
