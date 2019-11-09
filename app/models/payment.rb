class Payment < ApplicationRecord
  has_many :orders

  validates :name, presence: true, uniqueness: {case_sensitive: false}

  scope :filter_by, ->(params){where "name like ?", "%#{params}%"}
end
