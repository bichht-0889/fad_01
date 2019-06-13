module ApplicationHelper
  def full_title page_title
    base_title = I18n.t ".title"
    if page_title.blank?
      base_title
    else
      page_title + " | " + base_title
    end
  end

  def load_categories
    @categories = Category.all
  end

  def load_size_users
    User.count
  end

  def load_size_orders
    Order.count
  end

  def load_size_products
    Product.count
  end

  def load_size_categories
    Category.count
  end
end
