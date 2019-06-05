class Rate < ApplicationRecord
  belongs_to :product
  belongs_to :user

  delegate :name, to: :user

  scope :order_desc, ->{order(created_at: :desc)}
  scope :cal_avg_rating, ->(id){where(product_id: id).average(:rating)}
end
