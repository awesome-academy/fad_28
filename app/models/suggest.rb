class Suggest < ApplicationRecord
  validates :your_name, :product_name, :image, presence: true
  validates :your_name, length: {maximum: Settings.size.of_name}
end
