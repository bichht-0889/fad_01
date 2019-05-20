module ApplicationHelper
  def full_title page_title
    base_title = I18n.t ".title"
    if page_title.blank?
      base_title
    else
      page_title + " | " + base_title
    end
  end

  def load_categories
    @categories = Category.all
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
    return unless user_signed_in?
    if current_user.orders.waiting.present?
      session[:order_id] = current_user.orders.find_by(status: :waiting).id
      return current_user.orders.find_by(status: :waiting)
    else
      @current_order = current_user.orders.create
      create_order_waiting @current_order
    end
  end
end
