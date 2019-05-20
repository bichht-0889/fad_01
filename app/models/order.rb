class Order < ApplicationRecord
  belongs_to :user
  has_many :order_items, dependent: :destroy
  has_many :products, through: :order_items
  delegate :name, to: :user, prefix: :user
  delegate :name, to: :order_item, prefix: :order_item

  enum status: {waiting: 0, cancel: 1,
                confirm: 2, refuse: 3, accept: 4, finish: 5}
  scope :oldest_time, ->{order created_at: :asc}
  scope :search_status, ->(status){where status: status if status.present?}
  scope :period_time, -> do
    where created_at: (Time.now - Settings.statis.one.month)..Time.now
  end
  scope :date_start, ->(start){where("created_at >= ?", start)}
  scope :date_end, ->(date_end){where("created_at <= ?", date_end)}
  scope :revenue, ->{sum("total_price")}
  def confirm_quantity_product
    order_items.map do |order_item|
      @quantity = order_item.product.quantity
      if @quantity < order_item.quantity
        order_item.update_attribute :quantity, @quantity
      end
      @product = order_item.product
      @product.update_attribute(:quantity, @quantity - order_item.quantity)
    end
  end

  def cancel_quatity_product
    order_items.map do |order_item|
      @quantity = order_item.product.quantity
      @product = order_item.product
      @product.update_attribute(:quantity, @quantity + order_item.quantity)
    end
  end

  def remove_product quantity_order_item
    current_item = quantity_order_item
    if current_item.quantity > Settings.app.order.plus
      current_item.quantity -= Settings.app.order.plus
    end
    current_item
  end

  def add_product quantity_order_item
    current_item = quantity_order_item
    current_item.quantity += Settings.app.order.plus
    current_item
  end

  def subtotal_order
    order_items.reduce(0) do |sum, order_item|
      order_item.valid? ? sum + (order_item.quantity * order_item.price) : 0
    end
  end

  def order_mail_confirm
    OrderMailer.order_confirm(self).deliver_now
  end

  def order_mail_user
    OrderMailer.order_info(self).deliver_now
  end
end
