class ProductsController < ApplicationController
  include ProductsHelper
  before_action :load_filter, only: :index
  before_action :load_product, :load_rate, only: :show

  def index
    load_products
    @cur_slide_items = load_trend_items.take(Settings.products.cur_slide_items)
    @trend_items = load_trend_items.drop(Settings.products.cur_slide_items)
    @new_products = load_new_product
  end

  def show
    load_hot_items
    @list_pic = @product.picture_details
    @list_cmt = @product.comments.order_desc
    @list_comment = @list_cmt.paginate(page: params[:page],
      per_page: Settings.pages.per_page5)
    @list_rating = @product.rates.paginate(page: params[:page],
    per_page: Settings.pages.per_page10)
    @order_item = current_order.order_items.new if logged_in?
    @comment = @product.comments.new
  end

  private

  def load_hot_items
    @cur_slide_items = load_trend_items.take(Settings.products.cur_slide_items)
    @trend_items = load_trend_items.drop(Settings.products.cur_slide_items)
  end

  def load_rate
    @rate = @product.rates.find_by(user_id: current_user)
    @rate ||= Rate.new
  end
end
