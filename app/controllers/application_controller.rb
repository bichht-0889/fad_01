class ApplicationController < ActionController::Base
  include SessionsHelper
  before_action :configure_permitted_parameters, if: :devise_controller?
  
  def self.default_url_options
    {locale: I18n.locale}
  end

  def configure_permitted_parameters
    added_attrs = [:name, :email, :password, :password_confirmation,
     :phone, :address, :remember_me, :picture]
    devise_parameter_sanitizer.permit :sign_up, keys: added_attrs
    devise_parameter_sanitizer.permit :account_update, keys: added_attrs
  end
end
