class Comment < ApplicationRecord
  belongs_to :product
  belongs_to :user
  validates :content, presence: true

  delegate :name, to: :user

  scope :order_desc, ->{order(created_at: :desc)}
end
