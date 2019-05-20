class SearchsController < ApplicationController
    skip_authorization_check
    before_action :load_data
  
    def index
      @q = Product.ransack(params[:q])
      @products = @q.result().includes(:category).paginate(page: params[:page],
      per_page: Settings.pages.per_page9)
      @order_item = current_order.order_items.new if user_signed_in?
    end

    def load_data
      @data = ProductLib.new.load_data
    end
  end
  