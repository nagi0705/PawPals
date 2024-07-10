class Post < ApplicationRecord
  belongs_to :user
  belongs_to :group, optional: true

  has_one_attached :image

  has_many :comments, dependent: :destroy

  validates :title, presence: true
  validates :content, presence: true
end
