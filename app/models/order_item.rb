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

  private

  def product_present
    errors.add(:product, t("models.order_item.product_nil")) if product.nil?
  end

  def order_present
    errors.add(:order, t("models.order_item.order_nil")) if order.nil?
  end
end
