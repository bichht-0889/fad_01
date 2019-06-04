class StaticPagesController < ApplicationController
  include ProductsHelper
  before_action :load_filter, only: :home

  def home
    @load_products = load_products
    @cur_slide_items = load_trend_items.take(Settings.products.cur_slide_items)
    @trend_items = load_trend_items.drop(Settings.products.cur_slide_items)
    @new_products = load_new_product
    @order_item = current_order.order_items.new if logged_in?
  end
end
