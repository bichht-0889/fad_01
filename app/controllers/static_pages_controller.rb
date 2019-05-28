class StaticPagesController < ApplicationController
  include ProductsHelper
  before_action :load_filter, only: :home

  def home
    load_products
  end
end
