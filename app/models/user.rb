class User < ApplicationRecord
  has_many :evaluates, dependent: :destroy

  attr_accessor :remember_token

  FORMAT_EMAIL = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, uniqueness: {case_sensitive: false},
    format: {with: FORMAT_EMAIL}, length: {maximum: Settings.size.of_email}
  validates :name, presence: true, length: {maximum: Settings.size.of_name}
  validates :phone, numericality: true, allow_nil: true
  has_secure_password
  validates :password, presence: true, allow_nil: true,
    length: {minimum: Settings.size.of_password}

  enum role_id: {admin: 1, customer: 2}

  before_save{email.downcase!}

  def digest string
    cost =
      if ActiveModel::SecurePassword.min_cost
        BCrypt::Engine::MIN_COST
      else
        BCrypt::Engine.cost
      end
    BCrypt::Password.create string, cost: cost
  end

  def new_token
    SecureRandom.urlsafe_base64
  end

  def save_remember_token
    self.remember_token = new_token
    update_attribute :remember_digest, digest(remember_token)
  end

  def forget_remember_token
    update_attribute :remember_digest, nil
  end

  def authenticate? remember_token
    return false unless remember_digest
    BCrypt::Password.new(remember_digest).is_password? remember_token
  end
end
