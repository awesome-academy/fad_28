class Product < ApplicationRecord
  belongs_to :category
  has_many :evaluates, dependent: :destroy
  has_many :order_items, dependent: :destroy

  validates :name, :image, :category_id, presence: true
  validates :price, presence: true,
    numericality: {greater_than: Settings.smallest.of_price}
  validates :discount,
    numericality: {
      greater_than: Settings.smallest.of_discount,
      less_than: Settings.biggest.of_discount
    }
end
