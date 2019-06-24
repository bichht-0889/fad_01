class CheckoutsController < ApplicationController
  authorize_resource class: false
  before_action :load_order, only: :show

  def show; end

  private

  def load_order
    @order = Order.find_by id: params[:id]
    return if @order
    flash[:info] = t "controllers.checkout.order_not_exists"
    redirect_to root_path
  end
end
