class Category < ApplicationRecord
  has_many :products

  validates :name, presence: true, uniqueness: {case_sensitive: false}

  scope :filter, ->(params){where "name like ?", "%#{params}%"}
end
