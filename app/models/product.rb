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

  acts_as_paranoid

  mount_uploader :image, ImageUploader

  scope :timeout_discount, ->{where "close_discount_at < ?", Time.zone.now}
  scope :get_category, ->(id){where "category_id = ? or parent_id = ?", id, id}
  scope :newest, ->{order "created_at DESC"}
  scope :is_highlight, ->{where "sold_many = true"}
  scope :is_discount, ->{where "discount > 0"}
  scope :by_ids, ->(ids){where id: ids}
  scope :toggle_sold_many, (lambda do
    where "sold_many = 0 and id = ?", OrderItem.by_products.pluck(:product_id)
  end)
end
