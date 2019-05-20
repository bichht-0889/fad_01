class ProductsController < ApplicationController
  authorize_resource
  before_action :load_data, only: :index

  def index
    @products = @q.result.includes(:category).paginate(page: params[:page],
      per_page: Settings.pages.per_page9)
    @order_item = current_order.order_items.new if user_signed_in?
  end

  def show
    load_hot_items
    @list_pic = @product.picture_details
    @list_cmt = @product.comments.order_desc
    @list_comment = @list_cmt.paginate(page: params[:page],
      per_page: Settings.pages.per_page5)
    @rates = @product.rates
    @order_item = current_order.order_items.new if user_signed_in?
    @comment = @product.comments.new
  end

  private

  def load_data
    @data = ProductLib.new.load_data
  end
end
