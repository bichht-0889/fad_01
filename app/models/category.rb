class Category < ApplicationRecord
  has_many :products, dependent: :destroy
  has_many :sugests
  has_many :users, through: :sugests
  validates :name, presence: true
  enum status: {close: 0, open: 1}
end
