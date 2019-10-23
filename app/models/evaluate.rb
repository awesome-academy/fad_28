class Evaluate < ApplicationRecord
  belongs_to :user
  belongs_to :product

  validates :user_id, :product_id, presence: true
  validates :star,
    numercality: {
      only_integer: true,
      greater_than: Settings.smallest.of_star,
      less_than: Settings.biggest.of_star
    }
end
