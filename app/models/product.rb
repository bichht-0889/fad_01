class Product < ApplicationRecord
  belongs_to :category
  has_many :picture_details, dependent: :destroy
  has_many :order_items, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :rates, dependent: :destroy
  has_many :orders, through: :order_items
  has_many :user_rates, through: :rates, source: :user
  has_many :user_comments, through: :comments, source: :user
  mount_uploader :picture, PictureUploader
  validates :name, presence: true
  validates :price, presence: true
  validates :quantity, presence: true
  validates :description, presence: true
  validates :category_id, presence: true
  scope :get_category_id, ->(category_id){product category_id}
  scope :asc_name, ->{order name: :asc}
  mount_uploader :picture, PictureUploader
  def self.product category_id
    (where category_id: category_id) if category_id.present?
  end
  scope :find_by_ids, ->(ids){where id: ids}
  scope :load_product_by_created, ->{order created_at: :desc}
  scope :search_by_name, ->(name){where("name like ?", "%#{name}%")}
end
