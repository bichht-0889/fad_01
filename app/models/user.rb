class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  attr_accessor :activation_token
  has_many :orders, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :rates, dependent: :destroy
  has_many :sugests, dependent: :destroy
  has_many :product_rates, through: :rates, source: :product
  has_many :product_comments, through: :comments, source: :product
  has_many :categories, through: :sugests
  before_save{email.downcase!}
  before_create :create_activation_digest
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

  validates :password, presence: true,
             length: {minimum: Settings.app.user.password_min_length},
             allow_nil: true
  mount_uploader :picture, PictureUploader
  validate :picture_size
  enum role: {member: 0, admin: 1, block: 2}
  scope :asc_name, ->{order name: :asc}
  scope :block_user, ->{where.not role: :block}
  scope :period_time, -> do
    where created_at: (Time.now - Settings.statis.one.month)..Time.now
  end
  scope :date_start, ->(start){where("created_at >= ?", start)}
  scope :date_end, ->(date_end){where("created_at <= ?", date_end)}
  scope :users_activated, ->{where activated: true}
  def picture_size
    return unless picture.size > Settings.app.user.size.megabytes
    errors.add :picture, t("models.user.bug_size"),
      size: Settings.app.user.size
  end

  class << self
    def new_token
      SecureRandom.urlsafe_base64
    end

    def digest string
      cost = if ActiveModel::SecurePassword.min_cost
               BCrypt::Engine::MIN_COST
             else
               BCrypt::Engine.cost
             end
      BCrypt::Password.create(string, cost: cost)
    end
  end

  def authenticated? atribute, token
    digest = send("#{atribute}_digest")
    return false if digest.nil?
    BCrypt::Password.new(digest).is_password?(token)
  end

  def send_activation_email
    UserMailer.account_activation(self).deliver_now
  end

  def activate
    update_columns activated: true, activated_at: Time.zone.now
  end

  def self.send_mail_statistical
    UserMailer.mail_month(User.all.period_time,
      Order.all.period_time).deliver_now
  end

  private

  def create_activation_digest
    self.activation_token = User.new_token
    self.activation_digest = User.digest activation_token
  end
end
