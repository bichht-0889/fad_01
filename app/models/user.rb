class User < ApplicationRecord
  before_save{email.downcase!}
  has_many :orders, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :rates, dependent: :destroy
  has_many :sugests, dependent: :destroy
  has_many :product_rates, through: :rates, source: :product
  has_many :product_comments, through: :comments, source: :product
  has_many :categories, through: :sugests
  validates :name, presence: true,
             length: {maximum: Settings.app.user.name_max_length}
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true,
             length: {maximum: Settings.app.user.email_max_length},
                      format: {with: VALID_EMAIL_REGEX},
                      uniqueness: {case_sensitive: false}
  VALID_PHONE_REGEX = /\d[0-9]\)*\z/
  validates :phone, presence: true,
             length: {maximum: Settings.app.user.phone_max_length},
             format: {with: VALID_PHONE_REGEX}
  has_secure_password
  validates :password, presence: true,
             length: {minimum: Settings.app.user.password_min_length},
             allow_nil: true
  mount_uploader :picture, PictureUploader
  validate :picture_size
  enum role: {member: 0, admin: 1}

  def picture_size
    return unless picture.size > Settings.app.user.size.megabytes
    errors.add :picture, t("models.user.bug_size"),
      size: Settings.app.user.size
  end
end
