class Group < ApplicationRecord
  has_many :group_memberships, dependent: :destroy
  has_many :users, through: :group_memberships
  has_many :posts
  has_many :messages

  validates :name, presence: { message: "名前を入力してください。" }
  validates :description, presence: { message: "説明を入力してください。" }
end