class Order < ApplicationRecord
  belongs_to :payment, require: false
  has_many :order_items, dependent: :destroy

  FORMAT_EMAIL = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, uniqueness: {case_sensitive: false},
    format: {with: FORMAT_EMAIL}, length: {maximum: Settings.size.of_email}
  validates :name, presence: true, length: {maximum: Settings.size.of_name}
  validates :phone, numericality: true, on: :update
end
