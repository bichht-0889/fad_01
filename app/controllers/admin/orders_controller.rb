class Admin::OrdersController < ApplicationController
  authorize_resource
  before_action :load_order_admin, only: :update

  def index
    @order = Order.oldest_time.search_status(params[:status]).paginate(page:
     params[:page], per_page: Settings.app.admin.orders.per_page)
  end

  def update
    if params[:status] == Settings.app.admin.orders.accept
      accept
    elsif params[:status] == Settings.app.admin.orders.refuse
      refuse
    else
      flash[:info] = t "controllers.admin.order.not_found_status"
      redirect_to admin_orders_path
    end
  rescue NoMethodError => e
    lash[:danger] = t "controllers.admin.order.bug_update", name: e.message
    redirect_to admin_orders_path
  end

  private

  def accept
    @order.accept!
    flash[:success] = t "controllers.admin.order.accept_success"
    redirect_to admin_orders_path
  end

  def refuse
    @order.refuse!
    @order.cancel_quatity_product
    flash[:info] = t "controllers.admin.order.refuse_success"
    redirect_to admin_orders_path
  end

  def load_order_admin
    @order = Order.find_by id: params[:id]
    return if @order
    flash[:danger] = t "controllers.admin.order.not_found_order"
    redirect_to admin_orders_path
  end
end
