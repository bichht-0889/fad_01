class ProductsController < ApplicationController
  include ProductsHelper
  before_action :load_filter, only: :index

  def index
    load_products
    @cur_slide_items = load_trend_items.take(Settings.products.cur_slide_items)
    @trend_items = load_trend_items.drop(Settings.products.cur_slide_items)
    @new_products = load_new_product
  end
end
