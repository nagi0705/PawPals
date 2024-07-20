class Pet < ApplicationRecord
  belongs_to :user

  has_one_attached :image

  validates :name, presence: { message: 'を入力してください' }
  validates :species, presence: { message: 'を入力してください' }
  validates :age, presence: { message: 'を入力してください' }
  validates :kind, presence: { message: 'を入力してください' }
end
