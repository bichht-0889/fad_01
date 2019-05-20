class Order < ApplicationRecord
  belongs_to :user
  has_many :order_items, dependent: :destroy
  has_many :products, through: :order_items
  enum status: {waiting: 0, cancel: 1, refuse: 2, accept: 3}
end
