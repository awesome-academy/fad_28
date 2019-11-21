class Suggest < ApplicationRecord
  belongs_to :user
  validates :product_name, :image, :user_id, presence: true

  mount_uploader :image, ImageUploader

  scope :newest, ->{order "created_at DESC"}
  scope :not_seen, ->{where "admin_seen is null"}
end
