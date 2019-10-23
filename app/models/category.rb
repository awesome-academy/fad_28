class Category < ApplicationRecord
  has_many :products, dependent: :destroy

  validates :name, presence: true, uniquiness: {case_sensitive: false}
end
