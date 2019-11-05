class Product < ApplicationRecord
  belongs_to :category
  has_many :evaluates, dependent: :destroy
  has_many :order_items, dependent: :destroy

  validates :name, :image, :category_id, presence: true
  validates :price, presence: true,
    numericality: {greater_than: Settings.smallest.of_price}
  validates :discount, allow_nil: true,
    numericality: {
      greater_than: Settings.smallest.of_discount,
      less_than: Settings.biggest.of_discount
    }

  mount_uploader :image, ImageUploader

  scope :only_category, ->(id){where "category_id = ? or parent_id = ?", id, id}
  scope :timeout_discount, ->{where "close_discount_at < ?", Time.zone.now}
  scope :filter_by, ->(params){where "name like ?", "%#{params}%"}
end
