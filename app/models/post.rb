class Post < ApplicationRecord
  belongs_to :user
  belongs_to :group, optional: true

  has_one_attached :image

  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :liked_by_users, through: :likes, source: :user

  validates :title, presence: true
  validates :content, presence: true
end
