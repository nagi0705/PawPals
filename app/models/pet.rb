class Pet < ApplicationRecord
  belongs_to :user

  has_one_attached :image

  validates :name, presence: { message: '名前を入力してください' }
  validates :species, presence: { message: '種類を入力してください' }
  validates :age, presence: { message: '年齢を入力してください' }
  validates :kind, presence: { message: 'カラーを入力してください' }
end
