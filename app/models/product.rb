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

  scope :filter_by, ->(params){where "name like ?", "%#{params}%"}
  scope :timeout_discount, ->{where "close_discount_at < ?", Time.zone.now}
  scope :get_category, ->(id){where "category_id = ? or parent_id = ?", id, id}
  scope :newest, ->{order "created_at DESC"}
  scope :is_highlight, ->{where "sold_many = true"}
  scope :is_discount, ->{where "discount > 0"}
  scope :search_by,
    (lambda do |names|
      where "categories.name like ? or products.name like ? or price like ?",
        "%#{names}%", "%#{names}%", "%#{names}%"
    end)
  scope :min_price, ->(price){where "price >= ?", price}
  scope :max_price, ->(price){where "price <= ?", price}
  scope :by_ids, ->(ids){where id: ids}
end
