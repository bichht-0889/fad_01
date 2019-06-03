class Sugest < ApplicationRecord
  belongs_to :user
  belongs_to :category
  validates :name, presence: true
  validates :description, presence: true
  enum status: {default_create: 0, new_cate: 1,
                accept: 2, refuse: 3}

  scope :order_by_created, ->{order(created_at: :desc)}
end
