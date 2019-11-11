class Order < ApplicationRecord
  belongs_to :payment
  has_many :order_items, dependent: :destroy

  attr_accessor :remember_token

  FORMAT_EMAIL = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, uniqueness: {case_sensitive: false},
    format: {with: FORMAT_EMAIL},
      length: {maximum: Settings.size.of_email}, on: :update
  validates :name, presence: true,
    length: {maximum: Settings.size.of_name}, on: :update
  validates :phone, numericality: true, on: :update

  before_create :set_default_payment

  enum status_id: {Progress: 1, Place: 2, Transport: 3, Finish: 4, Cancel: 5}

  def set_default_payment
    self.payment_id = 1
  end

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

  def authenticate? token
    return unless token
    BCrypt::Password.new(remember_digest).is_password? token
  end
end
