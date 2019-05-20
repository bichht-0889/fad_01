class AccountActivationsController < ApplicationController
  authorize_resource class: false
  def edit
    user = User.find_by email: params[:email]
    if user && !user.activated? && user.authenticated?(:activation, params[:id])
      user.activate
      flash[:success] = t "controllers.account_activation.activate_success"
    else
      flash[:danger] = t "controllers.account_activation.activate_danger"
    end
    redirect_to root_path
  end
end
