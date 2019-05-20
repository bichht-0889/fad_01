class ApplicationController < ActionController::Base
  include SessionsHelper
  check_authorization
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

  rescue_from CanCan::AccessDenied do |exception|
    if user_signed_in?
      respond_to do |format|
        format.json {head :forbidden, content_type: "text/html"}
        format.html {redirect_to main_app.root_url, notice: exception.message}
        format.js   {head :forbidden, content_type: "text/html"}
      end
    else
      flash[:danger] = exception.message
      redirect_to signin_path
    end
  end
end
