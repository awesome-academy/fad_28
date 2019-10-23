class Payment < ApplicationRecord
  has_many :orders

  validates :name, presence: true, uniqueness: {case_sensitive: false}
end
