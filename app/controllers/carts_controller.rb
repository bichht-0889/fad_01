class CartsController < ApplicationController
  before_action :check_loggin

  def index
    @order = current_user.orders.waiting.first
    @order_items = @order.order_items
  end

  def update
    @order = Order.find_by(id: session[:order_id])
    if @order
      ActiveRecord::Base.transaction do
        @order.confirm!
        @order.confirm_quantity_product
        @order.order_mail_confirm
        @order.order_mail_user
        current_order
      end
    else
      flash[:info] = t "controllers.cart.order_not_exitst"
    end
    redirect_to root_path
  rescue Exception
    flash[:danger] = t "controllers.cart.bug_checkout"
    redirect_to carts_path
  end

  def show
    @order = Order.find_by id: params[:id]
    return if @order
    flash[:info] = t "controllers.cart.order_not_exitst"
    redirect_to root_path
  end
end
