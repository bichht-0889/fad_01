class CheckoutsController < ApplicationController
  before_action :check_loggin, :load_order

  def show; end

  private

  def load_order
    @order = Order.find_by id: params[:id]
    return if @order
    flash[:info] = t "controllers.checkout.order_not_exists"
    redirect_to root_path
  end
end
