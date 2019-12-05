class OrderItem < ApplicationRecord
  belongs_to :product
  belongs_to :order

  validates :product_id, :order_id, presence: true
  validates :quantity, presence: true,
    numericality: {
      only_integer: true,
      greater_than: Settings.smallest.of_quantity,
      less_than: Settings.biggest.of_quantity
    }
  scope :by_products, (lambda do
    group(:product_id).having("sum(quantity) > #{Settings.sum_quantity}")
  end)
end
