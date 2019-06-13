module SessionsHelper
  def redirect_back_or default
    redirect_to(session[:forwarding_url] || default)
    session.delete(:forwarding_url)
  end

  def store_location
    session[:forwarding_url] = request.original_url if request.get?
  end

  def create_order_waiting current_order
    if current_order.save
      session[:order_id] = current_order.id
      current_order
    else
      flash[:info] = t "helpers.session.bug_create_helper"
      redirect_to root_path
    end
  end

  def current_order
    return unless signed_in?
    if current_user.orders.waiting.present?
      session[:order_id] = current_user.orders.find_by(status: :waiting).id
      return current_user.orders.find_by(status: :waiting)
    else
      @current_order = current_user.orders.create
      create_order_waiting @current_order
    end
  end

  def log_out
    session.delete :user_id
    session.delete :order_id
    @current_user = nil
    @current_order = nil
  end

  def check_loggin
    return if signed_in?
    store_location
    flash[:info] = t "helpers.session.not_signed_in"
    redirect_to login_path
  end

  def check_role_admin
    return if current_user.admin?
    flash[:danger] = t "helpers.session.not_admin"
    redirect_to root_path
  end

  def signed_in_user
    return if signed_in?
    flash[:danger] = t "controllers.user.not_login"
    redirect_to login_path
  end

  def categories
    Category.all
  end
end
