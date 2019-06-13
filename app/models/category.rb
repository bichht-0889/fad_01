class Category < ApplicationRecord
  has_many :products, dependent: :destroy
  has_many :sugests
  has_many :users, through: :sugests
  validates :name, presence: true
  enum status: {close: 0, open: 1}
  default_scope{where status: open}
  scope :order_categories, -> {order(created_at: :desc)}
end
