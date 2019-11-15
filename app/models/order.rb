class Order < ApplicationRecord
  belongs_to :payment
  has_many :order_items, dependent: :destroy

  FORMAT_EMAIL = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, format: {with: FORMAT_EMAIL},
      length: {maximum: Settings.size.of_email}, on: :update
  validates :name, presence: true,
    length: {maximum: Settings.size.of_name}, on: :update
  validates :phone, numericality: true, on: :update

  before_create :set_default_payment

  enum status_id: {place: 1, transport: 2, finish: 3}

  ORDER_PARAMS = [:payment_id, :name, :email, :address, :phone]

  scope :newest, ->{order "created_at DESC"}
  scope :by_user, ->(mail){where "email = ?", mail}

  def set_default_payment
    self.payment_id = 1
  end

  def send_email_for_customer
    OrderMailer.notice_customer(self).deliver_now
  end

  def send_email_for_admin
    AdminMailer.notice_admin(self).deliver_now
  end
end
