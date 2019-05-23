class Product < ApplicationRecord
  belongs_to :category
  has_many :picture_details, dependent: :destroy
  has_many :order_items, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :rates, dependent: :destroy
  has_many :orders, through: :order_items
  has_many :user_rates, through: :rates, source: :user
  has_many :user_comments, through: :comments, source: :user

  scope :get_category_id, ->(category_id){where(category_id: category_id) if category_id.first.present?}
end
