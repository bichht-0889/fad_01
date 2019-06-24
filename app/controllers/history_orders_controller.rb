class HistoryOrdersController < ApplicationController
  authorize_resource class: false
  before_action :load_order, only: :index

  def index
    @order_waiting = @orders.waiting
    @order_cancel = @orders.cancel
    @order_confirm = @orders.confirm
    @order_refuse = @orders.refuse
    @order_accept = @orders.accept
    @order_finish = @orders.finish
  end

  def update
    @orders = Order.find_by id: params[:id]
    if @orders
      @orders.update_attribute :status, :cancel
      @orders.cancel_quatity_product
      redirect_to history_orders_path
    else
      flash[:info] = t "controllers.history_order.order_not_found"
      redirect_to root_path
    end
  end

  private

  def load_order
    @orders = current_user.orders
  end
end
