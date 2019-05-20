class Admin::ProductsController < ApplicationController
  authorize_resource
  before_action :load_products, only: %i(edit update destroy)

  def new
    @product = Product.new
  end

  def create
    @product = Product.new params_product
    if @product.save
      flash[:success] = t "controllers.admin.product.post_success"
      redirect_to products_path
    else
      render :new
    end
  end

  def index
    @product = Product.paginate(page: params[:page],
      per_page: Settings.app.admin.product.per_page).asc_name
  end

  def edit; end

  def update
    if @product.update_attributes params_product
      flash[:success] = t "controllers.admin.product.update_success"
      redirect_to admin_products_path
    else
      render :edit
    end
  end

  def destroy
    ActiveRecord::Base.transaction do
      refuse_order @product.id
      if @product.destroy
        flash[:info] = t "controllers.admin.product.delete_success"
      else
        raise ActiveRecord::Rollback
      end
      redirect_to admin_products_path
    end
  rescue Exception
    flash[:danger] = t "controllers.admin.product.delete_bug"
    redirect_to admin_products_path
  end

  private

  def load_products
    @product = Product.find_by id: params[:id]
    return if @product
    flash[:info] = t "controllers.admin.product.not_found"
    redirect_to admin_products_path
  end

  def params_product
    params.require(:product).permit :name, :price, :quantity, :description,
      :picture, :category_id
  end

  def refuse_order product_id
    Order.confirm.each do |order|
      order.order_items.each do |order_items|
        next unless order_items.product_id == product_id
        @total_price_product = order_items.quantity * order_items.price
        @total_price = order.total_price - @total_price_product
        order.update! total_price: @total_price, status: :refuse
      end
    end
  end
end
