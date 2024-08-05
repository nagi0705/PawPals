class GrowthRecord < ApplicationRecord
  belongs_to :pet

  validates :weight, numericality: { greater_than_or_equal_to: 0 }, allow_nil: true
  validates :notes, length: { maximum: 1000 }, allow_blank: true
end