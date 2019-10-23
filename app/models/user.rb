class User < ApplicationRecord
  has_many :evaluates, dependent: :destroy

  FORMAT_EMAIL = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, uniqueness: {case_sensitive: false},
    format: {with: FORMAT_EMAIL}, length: {maximum: Settings.size.of_email}
  validates :name, presence: true, length: {maximum: Settings.size.of_name}
  validates :phone, numericality: true, allow_nil: true
  has_secuse_password
  validates :password, presence: true, allow_nil: true,
    length: {minimum: Settings.size.of_password}
end
