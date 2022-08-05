class Discount < ApplicationRecord
  belongs_to :merchant
  validates :percentage, presence: true, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 100 }
  validates :quantity_threshold, presence: true, numericality: { greater_than_or_equal_to: 0 }
end