class ProductsController < ApplicationController
  include ProductsHelper
  before_action :load_filter, only: :index
  before_action :load_product, only: :show

  def index
    load_products
    @cur_slide_items = load_trend_items.take(Settings.products.cur_slide_items)
    @trend_items = load_trend_items.drop(Settings.products.cur_slide_items)
    @new_products = load_new_product
  end

  def show
    load_hot_items
    @list_pic = @product.picture_details
  end

  private

  def load_hot_items
    @cur_slide_items = load_trend_items.take(Settings.products.cur_slide_items)
    @trend_items = load_trend_items.drop(Settings.products.cur_slide_items)
  end
end
