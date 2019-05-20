module ProductsHelper
  def filtering_params params
    params.slice :get_category_id
  end

  def load_filter
    @categories = Category.all
    @products = Product.paginate(page: params[:page],
     per_page: Settings.pages.per_page9)
    @order_item = current_order.order_items.new if current_user
  end

  def load_products
    filtering_params(params).each do |key, value|
      @products = @products.public_send(key, value) if value.present?
    end
    respond_to do |format|
      format.html {}
      format.js {}
    end
  end

  def load_trend_items
    trends = OrderItem.trend_items.limit(Settings.products.trend)
    list_ids = trends.map(&:product_id)
    Product.find_by_ids(list_ids)
  end

  def load_new_product
    Product.load_product_by_created.limit(Settings.products.news)
  end

  def load_product
    @product = Product.find_by id: params[:id]
    return if @product
    flash[:danger] = t "products.product_not_found"
    redirect_to products_path
  end
end
