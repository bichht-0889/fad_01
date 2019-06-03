class OrderItem < ApplicationRecord
  belongs_to :order
  belongs_to :product
  validates :quantity, presence: true,
    numericality: {only_integer: true, greater_than: 0}
  validate :product_present
  validate :order_present

  def subtotal
    quantity * price
  end
  
  scope :stock_take_products, -> do
    joins(:product)
    .group(:name)
    .sum(:quantity)
  end

  scope :stock_take_price, -> do
    joins(:product)
    .group(:name)
    .sum(:price)
  end

  scope :trend_items, -> do
    group(:product_id)
    .order("SUM(quantity) DESC")
    .select("product_id, SUM(quantity) AS total")
  end
    
  private

  def product_present
    errors.add(:product, t("models.order_item.product_nil")) if product.nil?
  end

  def order_present
    errors.add(:order, t("models.order_item.order_nil")) if order.nil?
  end
end
