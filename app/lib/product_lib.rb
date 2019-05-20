class ProductLib
  def load_data
    @data = {
      cur_slide_items: load_trend_items.take(Settings.products.cur_slide_items),
      trend_items: load_trend_items.drop(Settings.products.cur_slide_items),
      new_products: load_new_product
    }
  end

  def load_trend_items
    trends = OrderItem.trend_items.limit(Settings.products.trend)
    list_ids = trends.map(&:product_id)
    Product.find_by_ids(list_ids)
  end

  def load_new_product
    Product.load_product_by_created.limit(Settings.products.news)
  end
end
