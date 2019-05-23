module ProductsHelper
  def filtering_params params
    params.slice :get_category_id
  end

  def load_filter
    @categories = Category.all
    @products = Product.paginate(page: params[:page],
     per_page: Settings.pages.per_page9)
  end

  def load_products
    filtering_params(params).each do |key, value|
      @products = @products.public_send(key, value) if value.present?
    end
      respond_to do |format|
      format.html{}
      format.js{}
    end
  end
end
