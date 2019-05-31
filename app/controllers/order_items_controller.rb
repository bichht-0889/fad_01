class OrderItemsController < ApplicationController
  before_action :check_loggin, :current_user
  after_action :update_total_price
  before_action :load_order_item, only: %i(decrease increase update)
  before_action :load_order, only: %i(destroy subtotal_order update_total_price)
  skip_before_action :verify_authenticity_token

  def create
    @order = current_user.orders.waiting.first
    @order_item = @order.order_items.find_by(
      product_id: params[:order_item][:product_id]
    )
    @product = Product.find_by(id: params[:order_item][:product_id])
    if @product
      create_product_to_cart @product, @order_item, @order
    else
      flash[:info] = t "controllers.order_item.product_not_found"
      redirect_to root_path
    end
  end

  def update
    @product = @order_item.product
    @input_quantity = params[:order_item][:quantity].to_i
    if @input_quantity <= 0 || @input_quantity > @product.quantity
      @note = t "controllers.order_item.max_quantity", number: @product.quantity
      flash[:info] = @note
    else
      @order_item.update_attribute :quantity, @input_quantity
      update_total_price
    end
    @order_items = @order.order_items
    redirect_to carts_path
  end

  def destroy
    @order = Order.find_by id: session[:order_id]
    @order_item = @order.order_items.find_by id: params[:id]
    if @order_item.destroy
      flash[:info] = t "controllers.order_item.delete_success"
      @order_items = @order.order_items
      redirect_to carts_path
    else
      flash[:danger] = t "controllers.order_item.delete_bug"
    end
  end

  def subtotal_order
    @order.subtotal_order
  end

  def update_total_price
    @order.update_attribute :total_price, subtotal_order
  end

  def decrease
    @line_item = @order.remove_product @order_item
    respond_to do |format|
      if @line_item.save
        update_total_price
        @order_items = @order.order_items
        format.html{redirect_to @order_items}
      else
        format.html{redirect_to carts_path}
      end
      format.js
    end
  end

  def increase
    @product = Product.find_by id: @order_item.product_id
    if @product.quantity == @order_item.quantity
      quatity_equal @order, @product
    else
      @line_item = @order.add_product @order_item
      respond_to do |format|
        if @line_item.save
          update_total_price
          @order_items = @order.order_items
          format.html{redirect_to @order_items}
        else
          format.html{redirect_to carts_path}
        end
        format.js
      end
    end
  end

  def quatity_equal order, product
    @note = t "controllers.order_item.max_quantity", number: product.quantity
    respond_to do |format|
      @order_items = order.order_items
      format.html{redirect_to @order_items}
      format.js
    end
  end

  def plus_quantity check
    @quantity = check.quantity
    @order_item = check.update_attribute :quantity,
      @quantity + Settings.app.order_items.plus
  end

  def quantity_not_zero order_item, product, order
    if order_item.present?
      if order_item.quantity == product.quantity
        flash[:info] = t "controllers.order_item.max_quantity",
          number: product.quantity
      else
        plus_quantity order_item
      end
    else
      @order_item = order.order_items.new order_item_params
      @order_item.save
    end
  end

  def create_product_to_cart product, order_item, order
    if @product.quantity.zero?
      flash[:info] = t "controllers.order_item.quantity_zero"
      redirect_to root_path
    else
      quantity_not_zero order_item, product, order
    end
  end

  private

  def load_order_item
    @order = current_order
    @order_item = OrderItem.find_by id: params[:id]
  end

  def load_order
    @order = Order.find_by id: session[:order_id]
    return if @order
    flash[:danger] = t "controllers.order_item.order_not_found"
    redirect_to root_path
  end

  def order_item_params
    params.require(:order_item).permit :price, :product_id, :quantity
  end
end
