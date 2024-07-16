class Pet < ApplicationRecord
  belongs_to :user

  has_one_attached :image

  validates :name, presence: true
  validates :species, presence: true
  validates :age, presence: true
  validates :kind, presence: true
end
