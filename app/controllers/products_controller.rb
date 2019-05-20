class ProductsController < ApplicationController
  include ProductsHelper
  before_action :load_filter, only: :index

  def index
    load_products
  end
end
