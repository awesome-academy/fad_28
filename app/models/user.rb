class User < ApplicationRecord
  has_many :evaluates, dependent: :destroy

  attr_accessor :remember_token, :reset_password_token

  FORMAT_EMAIL = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, uniqueness: {case_sensitive: false},
    format: {with: FORMAT_EMAIL}, length: {maximum: Settings.size.of_email}
  validates :name, presence: true, length: {maximum: Settings.size.of_name}
  validates :phone, numericality: true, allow_nil: true
  has_secure_password
  validates :password, presence: true,
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

  def authenticate? attribute, token
    digest = send "#{attribute}_digest"
    return false unless digest
    BCrypt::Password.new(digest).is_password? token
  end

  def save_reset_password_token
    self.reset_password_token = new_token
    update_attribute :reset_password_digest, digest(reset_password_token)
  end

  def send_email_reset_password
    UserMailer.reset_password(self).deliver_now
  end

  def clear_reset_password_token
    update_attribute :reset_password_digest, nil
  end
end
