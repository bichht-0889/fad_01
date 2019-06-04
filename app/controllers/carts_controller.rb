class CartsController < ApplicationController
  before_action :check_loggin

  def index
    @order = current_user.orders.waiting.first
    @order_items = @order.order_items
  end

  def update
    @order = Order.find_by(id: session[:order_id])
    if @order
      @order.update_attribute(:status, :confirm)
      @order.confirm_quantity_product
      current_order
      redirect_to carts_path
    else
      flash[:info] = t "controllers.cart.order_not_exitst"
      redirect_to root_path
    end
  end
end
